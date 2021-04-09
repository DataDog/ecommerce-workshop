
variable "instance_type" {
  description = "Instance type to use for each host."
  type        = string
  default     = "t2.medium"
}
variable "region" {
  type    = string
  default = "us-west-1"
}
variable "keyname" {
  description = "Name of the ssh key to use"
  default     = "ecommerceapp"
}
variable "owner" {
  type    = string
  default = "mattw"
}

variable "ddapikey" {
  type      = string
  sensitive = true
}

variable "ddappkey" {
  type      = string
  sensitive = true
}

variable "clienttoken" {
  type = string
}

variable "rumappid" {
  type = string
}
