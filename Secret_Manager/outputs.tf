output "secret_id" {
  description = "Secret id"
  value       = aws_secretsmanager_secret.secret.id
}

output "secret_arn" {
  description = "Secret arn"
  value       = aws_secretsmanager_secret.secret.arn
}