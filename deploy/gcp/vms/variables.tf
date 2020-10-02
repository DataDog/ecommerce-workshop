variable "dd_api_key" {
  type        = string
  description = "Datadog Agent API key"
}

variable "name" {
  type        = string
  description = "name of instance. default is datadog-ecommerce"
  default     = "datadog-ecommerce"
}

variable "machine_type" {
  type        = string
  description = "size of instance. default is n1-standard-2"
  default     = "n1-standard-2"
}

variable "network_name" {
  type        = string
  description = "gcp network name. default is default"
  default     = "default"
}

variable "zone" {
  type        = string
  description = "gcp zone to deploy"
  default     = "us-east1-b"
}

variable "enable_firewall_rule" {
  type        = bool
  description = "creates firewall rule to allow public traffic"
  default     = true
}

variable "docker_compose_file" {
  type        = string
  description = "docker-compose file to deploy. defaults to docker-compose-fixed-instrumented"
  default     = "docker-compose-fixed-instrumented"
}