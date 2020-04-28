terraform {
  required_version = "~>0.12"
}

provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}