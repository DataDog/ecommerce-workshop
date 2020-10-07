output "kubernetes_cluster_ipv4" {
  value = digitalocean_kubernetes_cluster.ecommerce.ipv4_address
}

output "kubernetes_cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.ecommerce.endpoint
}
