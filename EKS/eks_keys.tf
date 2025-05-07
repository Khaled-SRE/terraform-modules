resource "aws_kms_key" "enc_kms_key" {
  description             = "KMS key eks"
  deletion_window_in_days = 30
}