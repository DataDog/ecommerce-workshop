
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
variable "mainami" {
  type    = string
  default = "ami-0121ef35996ede438"
}
variable "mainamiuser" {
  type    = string
  default = "ubuntu"
}

variable "rubyami" {
  type    = string
  default = "ami-072df871c83814231"
}
variable "rubyamiuser" {
  type    = string
  default = "bitnami"
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
