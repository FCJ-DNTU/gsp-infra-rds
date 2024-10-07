variable "region" {
  description = "Region name of infrastructure"
  type = string
}

variable "key_name" {
  description = "Name of SSH Key Pair"
  type = string
}

variable "author" {
  description = "Creator of this resource"
  type = string
}

variable "compute_root_name" {
  description = "Root name of Compute services"
  type = string
}

variable "subnet_id" {
  description = "Id of subnet"
  type = string
}

variable "security_group_ids" {
  description = "List of SG Ids"
  type = set(string)
}