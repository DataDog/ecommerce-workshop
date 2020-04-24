terraform {
  required_version = "~>0.12"
}

provider "google" {
  version = "~> 3.18"
  zone    = var.zone
}