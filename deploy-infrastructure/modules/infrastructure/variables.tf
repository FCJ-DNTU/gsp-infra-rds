variable "region" {
  description = "Region name of infrastructure"
  type = string
}

variable "author" {
  description = "Creator of this resource"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR Block of VPC"
  type = string
}

variable "network_root_name" {
  description = "Root name of Network (use for all VPC resources)"
  type = string
}