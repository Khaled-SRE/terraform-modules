variable "acm_domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route53 hosted zone ID for DNS validation"
  type        = string
}