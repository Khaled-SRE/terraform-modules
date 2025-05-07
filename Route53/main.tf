resource "aws_route53_zone" "main" {
  name          = var.domain_name
  tags          = var.tags
  force_destroy = true

  # Check if vpc_id is provided before adding the vpc block
  dynamic "vpc" {
    for_each = var.vpc_id != null ? [1] : []
    content {
      vpc_id = var.vpc_id
    }
  }
}

resource "aws_route53_record" "dns_records" {
  for_each = var.records
  zone_id = aws_route53_zone.main.zone_id
  name    = each.key
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}