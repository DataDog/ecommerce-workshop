resource "aws_instance" "ecommerce" {
  ami           = "ami-085925f297f89fce1" # ubuntu image
  instance_type = "t2.micro"

  tags = {
      Name = "eCommerce Monolith"
  }

  provisioner "file" {
      source = "provision.sh"
      destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
      inline = [
          "chmod +x /tmp/provision.sh",
          "/tmp/script.sh ${var.dd_api_key}"
      ]
  }
}