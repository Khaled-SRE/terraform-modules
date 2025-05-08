output "certificate_arn" {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.certificate.arn
}

output "certificate_domain_name" {
  description = "The domain name for the certificate"
  value       = aws_acm_certificate.certificate.domain_name
}

output "certificate_status" {
  description = "The status of the certificate"
  value       = aws_acm_certificate.certificate.status
}