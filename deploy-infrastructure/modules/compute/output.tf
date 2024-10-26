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

output "alb_id" {
  value = aws_lb.alb.id
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_endpoint" {
  value = aws_lb.alb.dns_name
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}