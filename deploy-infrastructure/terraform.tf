# Setup local variables
locals {
  region = "ap-southeast-2"
  author = "FCJ-DNTU"
  network_root_name = "FCJ-Lab"
  compute_root_name = "FCJ-Lab"
  vpc_cidr = "10.0.0.0/16"
  db_username = "admin"
  db_password = "letmein12345"
  db_name = "fcjresbar"
  key_name = "general-use"
  service_discovery_namespace_name = "fcjresbar.internal"
  service_discovery_service_name = "backend"
}

# Setup provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.region
}