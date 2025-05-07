resource "aws_secretsmanager_secret" "secret" {
  name                    = var.secret_name
  recovery_window_in_days = 0
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secret.arn
  secret_string = var.secret_key_value != null ? jsonencode(var.secret_key_value) : null
  depends_on    = [aws_secretsmanager_secret.secret]
}