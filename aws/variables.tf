variable "dd_api_key" {
  type        = string
  description = "Datadog Agent API key"
}

variable "postgres_username" {
  type        = string
  description = "Username for postgres"
  default     = "postgres"
}

variable "postgres_password" {
  type        = string
  description = "Password for postgres"
}