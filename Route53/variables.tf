variable "domain" {
  type        = string
  description = "The domain name of the hosted zone"
}

variable "description" {
  type        = string
  default     = null
  description = "The description for the hosted zone. Defaults to 'Managed by Terraform'"
}

variable "private_zone" {
  type        = map
  default     = null
  description = "A mapping to associate a VPC"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the zone"
}

variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster for external-dns integration"
  default     = "default"
}