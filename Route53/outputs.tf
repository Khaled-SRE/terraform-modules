output "hosted_zone_id" {
  description = "The ID of the created hosted zone"
  value       = aws_route53_zone.main.zone_id
}

output "dns_records" {
  description = "The DNS records created"
  value       = aws_route53_record.dns_records
}