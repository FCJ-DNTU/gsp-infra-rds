output "ec2_id" {
  value = aws_instance.my_server.id
}

output "ec2_arn" {
  value = aws_instance.my_server.arn
}

output "ec2_public_ipv4" {
  value = aws_instance.my_server.public_ip
}

output "ec2_public_dns_name" {
  value = aws_instance.my_server.public_dns
}