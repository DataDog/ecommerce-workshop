data "digitalocean_kubernetes_versions" "stable" {
  version_prefix = "1.18."
}

resource "digitalocean_kubernetes_cluster" "k8s_cluster" {
  name         = var.cluster_name
  region       = var.region
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.stable.latest_version
  tags         = ["development"]

  node_pool {
    name       = "worker"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}
