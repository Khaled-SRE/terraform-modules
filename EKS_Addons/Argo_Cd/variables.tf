variable "chart_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "5.46.7"
}

variable "rollouts_version" {
  description = "Version of the Argo Rollouts Helm chart"
  type        = string
  default     = "2.35.0"
}


variable "argocd_domain_name" {
  description = "Domain name for ArgoCD"
  type        = string
}

variable "ingress_group_name" {
  description = "Name of the ingress group"
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

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for the ALB"
  type        = string
}
