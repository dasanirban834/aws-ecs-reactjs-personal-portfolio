resource "aws_cloudwatch_log_group" "log-group" {
  name = var.cw_log_grp
  tags = var.custom_tags
}