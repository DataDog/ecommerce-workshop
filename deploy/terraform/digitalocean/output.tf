resource "local_file" "kube_config_server_yaml" {
  filename          = format("%s/../../%s", path.root, "kube_config_server.yaml")
  sensitive_content = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].raw_config
  file_permission   = "0600"
}
