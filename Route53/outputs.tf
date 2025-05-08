output "zone_id" {
  value       = aws_route53_zone.this.zone_id
  description = "The Hosted Zone ID"
}

output "name_servers" {
  value       = aws_route53_zone.this.name_servers
  description = "A list of name servers in associated delegation set"
}

output "name" {
  value       = aws_route53_zone.this.name
  description = "The name of the hosted zone"
}

output "arn" {
  value       = aws_route53_zone.this.arn
  description = "The ARN of the hosted zone"
}