# DigitalOcean API Token. This can also be set via the
# TF_VAR_do_token environment variable
variable "do_token" {}

variable "region" {
  description = "The DigitalOcean region to deploy the k8s cluster into"
  type        = string
  default     = "nyc1"
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "ecommerce"
}

variable "node_pool_name" {
  description = "Name of the Kubernetes worker pool nodes"
  type        = string
  default     = "worker"
}

variable "node_size" {
  description = "Cluster node size. See https://slugs.do-api.dev/ for slug options."
  type        = string
  default     = "s-2vcpu-2gb"
}

variable "node_count" {
  description = "Number of nodes in the Kubernetes pool"
  type        = number
  default     = 2
}
