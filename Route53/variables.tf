variable "domain_name" {
  description = "The domain name for Route 53"
}

variable "zone_type" {
  description = "The type of hosted zone (public or private)"
  default     = "public"
}

variable "tags" {
  description = "Additional tags for the hosted zone"
  type        = map(string)
  default     = {}
}

variable "records" {
  description = "A map of DNS records to create"
  type        = map(object({
    type    = string
    ttl     = number
    records = list(string)
  }))
  default     = {}
}

variable "vpc_id" {
  type = string
  description = "The ID of the VPC for private zones"
  default     = null
}
variable "private_zone" {
  type        = map
  default     = null
  description = "A mapping to associate a VPC"
}