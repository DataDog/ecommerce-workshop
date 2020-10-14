output "kubernetes_cluster_ipv4" {
  value = digitalocean_kubernetes_cluster.ecommerce.ipv4_address
}

output "kubernetes_cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.ecommerce.endpoint
}

resource "local_file" "kube_config_server_yaml" {
  filename          = format("%s/%s", path.root, "kube_config_server.yaml")
  sensitive_content = digitalocean_kubernetes_cluster.ecommerce.kube_config[0].raw_config
}
