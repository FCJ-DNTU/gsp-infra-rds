output "code_deploy_role_id" {
  value = aws_iam_role.code_deploy_role.id
}

output "code_deploy_role_arn" {
  value = aws_iam_role.code_deploy_role.arn
}