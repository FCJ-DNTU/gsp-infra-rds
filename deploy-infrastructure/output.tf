# Output of Infrastructure
# VPC
output "vpc_id" {
  value = module.infrastructure.vpc_id
}

output "vpc_arn" {
  value = module.infrastructure.vpc_arn
}

# Internet gateway
output "igw_id" {
  value = module.infrastructure.igw_id
}

output "igw_arn" {
  value = module.infrastructure.igw_arn
}

# Output of Security Group
output "public_sg_id" {
  value = module.security.public_sg_id
}

output "public_sg_arn" {
  value = module.security.public_sg_arn
}

output "db_sg_id" {
  value = module.security.db_sg_id
}

output "db_sg_arn" {
  value = module.security.db_sg_arn
}

# Output of EC2
output "ec2_id" {
  value = module.compute.ec2_id
}

output "ec2_arn" {
  value = module.compute.ec2_arn
}

output "ec2_public_ipv4" {
  value = module.compute.ec2_public_ipv4
}

output "ec2_public_dns_name" {
  value = module.compute.ec2_public_dns_name
}

# Output of RDS
output "db_instance_id" {
  value = module.rds.db_instance_id
}

output "db_instance_arn" {
  value = module.rds.db_instance_arn
}

output "db_instance_identifier" {
  value = module.rds.db_instance_identifier
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}