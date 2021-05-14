resource "google_compute_instance" "ecommerce" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["datadog", "ecommerce"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = var.network_name

    access_config {
      nat_ip = google_compute_address.ecommerce.address
    }
  }

  metadata = {
    owner       = "datadog"
    application = "ecommerce"
  }

  metadata_startup_script = <<EOT
  #!/bin/bash
  set -e

  timeout 180 /bin/bash -c \
    'until stat /var/lib/cloud/instance/boot-finished 2>/dev/null; do echo waiting ...; sleep 1; done'

  echo "[Unit]
Description=GOR for Datadog
After=local-fs.target network-online.target network.target rsyslog.service
After=google-instance-setup.service google-network-setup.service
Wants=local-fs.target network-online.target network.target

[Service]
WorkingDirectory=/root/ecommerce-workshop
ExecStart=/usr/local/bin/gor --input-file-loop --input-file requests_0.gor --output-http http://localhost:3000
KillMode=process
Type=simple

[Install]
WantedBy=multi-user.target
" > /lib/systemd/system/gor.service
  
  export DEBIAN_FRONTEND=noninteractive

  apt-get -y install apt-transport-https ca-certificates curl software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

  apt-get update

  apt-get -y install docker-ce

  curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose

  apt-get -y install git wget

  mkdir /root/ecommerce-workshop

  git clone https://github.com/DataDog/ecommerce-workshop.git  /root/ecommerce-workshop

  curl -L https://github.com/buger/goreplay/releases/download/v1.0.0/gor_1.0.0_x64.tar.gz -o gor_1.0.0_x64.tar.gz
  tar -xf gor_1.0.0_x64.tar.gz
  mv gor /usr/local/bin/gor
  rm -rf gor_1.0.0_x64.tar.gz

  POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres POSTGRES_URL=db DD_API_KEY=${var.dd_api_key} docker-compose -f /root/ecommerce-workshop/docker-compose-files/${var.docker_compose_file}.yml up -d
  systemctl start gor
  EOT

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}