output "host" {
  description = "Hostname of the k8s cluster"
  value       = digitalocean_kubernetes_cluster.k8s_cluster.endpoint
}

output "token" {
  description = "k8s cluster access token"
  value       = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].token
}

output "cluster_ca_certificate" {
  description = "k8s cluster CA Certificate"
  value = base64decode(
    digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].cluster_ca_certificate
  )
}

output "kube_config" {
  description = "YAML Output for kubectl configuration"
  value       = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].raw_config
}

output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = var.cluster_name
}
