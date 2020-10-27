data "digitalocean_kubernetes_versions" "stable" {
  version_prefix = "1.19."
}

resource "digitalocean_kubernetes_cluster" "k8s_cluster" {
  # See variables.tf for adjustable options
  name   = var.cluster_name
  region = var.region
  # Set this to false if you want to disable automatic upgrading of your cluster
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.stable.latest_version
  tags         = ["development"]

  node_pool {
    name       = var.node_pool_name
    size       = var.node_size
    node_count = var.node_count
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.k8s_cluster.endpoint
  token = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].cluster_ca_certificate
  )
}
