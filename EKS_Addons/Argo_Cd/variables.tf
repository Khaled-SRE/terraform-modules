variable "version" {
  description = "The chart version"
  type    = string
  default = "5.27.3"
}

variable "argocd_domain_name" {
  description = "The domain name used to expose ArgoCD via ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN for ALB HTTPS listener"
  type        = string
}

variable "ingress_group_name" {
  type = string
}
