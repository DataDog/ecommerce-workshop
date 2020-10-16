resource "local_file" "kube_config_server_yaml" {
  filename          = format("%s/%s", path.root, "kube_config_server.yaml")
  sensitive_content = module.k8s_cluster.kube_config
}
