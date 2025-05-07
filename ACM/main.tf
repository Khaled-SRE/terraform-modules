resource "aws_acm_certificate" "certificate" {
  domain_name               = var.acm_domain_name
  subject_alternative_names = ["*.${var.acm_domain_name}"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "certificate" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_type
  zone_id         = var.hosted_zone_id
  ttl             = 300
}


resource "aws_acm_certificate_validation" "cert_validate" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.certificate.fqdn]
}