output "ecr_uri" {
  value = aws_ecr_repository.ecr.repository_url
}

output "ecr_arn" {
  value = aws_ecr_repository.ecr.arn
}

output "ecr_name" {
  value = aws_ecr_repository.ecr.name
}