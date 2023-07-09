resource "aws_kms_key" "kms" {
  description             = var.kms_key["description"]
  deletion_window_in_days = var.kms_key["deletion_window_in_days"]
  tags                    = var.custom_tags
}