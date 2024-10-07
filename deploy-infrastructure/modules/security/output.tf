output "public_sg_id" {
  value = aws_security_group.public_sg.id
}

output "public_sg_arn" {
  value = aws_security_group.public_sg.arn
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "db_sg_arn" {
  value = aws_security_group.db_sg.arn
}