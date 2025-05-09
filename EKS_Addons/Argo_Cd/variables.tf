variable "chart_version" {
  description = "Version of the Argo CD Helm chart"
  type        = string
  default     = "5.51.4"
}

variable "rollouts_version" {
  description = "The version of the Argo Rollouts Helm chart"
  type        = string
  default     = "2.21.0"
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
  description = "The name of the ingress group for ALB"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace to deploy Argo CD"
  type        = string
  default     = "argocd"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
