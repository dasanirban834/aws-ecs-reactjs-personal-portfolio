output "ecs_arn" {
  value = aws_ecs_cluster.aws-ecs-cluster.id
}

output "cw_log_group_arn" {
  value = aws_cloudwatch_log_group.log-group.arn
}

output "kms_id" {
  value = aws_kms_key.kms.id
}

output "kms_arn" {
  value = aws_kms_key.kms.arn
}

