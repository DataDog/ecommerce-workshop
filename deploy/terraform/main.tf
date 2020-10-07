# Pin Terraform to at least latest
terraform {
  required_version = "~>0.13"
}

# DigitalOcean API Token. This can also be set via the
# TF_VAR_do_token environment variable
variable "do_token" {}

variable "do_region" {
  default = "nyc1"
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "stable" {
  version_prefix = "1.18."
}

resource "digitalocean_kubernetes_cluster" "ecommerce" {
  name         = "ecommerce"
  region       = var.do_region
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.stable.latest_version
  tags         = ["development"]

  node_pool {
    name       = "worker"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}

provider "kubernetes" {
    host = digitalocean_kubernetes_cluster.ecommerce.endpoint
    token = digitalocean_kubernetes_cluster.ecommerce.kube_config[0].token
    cluster_ca_certificate = base64decode(
        digitalocean_kubernetes_cluster.ecommerce.kube_config[0].cluster_ca_certificate
    )
}