variable "chart_version" {
  description = "Version of the External DNS Helm chart"
  type        = string
  default     = "1.13.1"
}

variable "domain" {
  type        = string
  description = "The domain name to be managed by external-dns"
}

variable "zone_name" {
  type        = string
  description = "The type of DNS zone (public or private)"
  default     = "public"
  validation {
    condition     = contains(["public", "private"], var.zone_name)
    error_message = "zone_name must be either 'public' or 'private'"
  }
}

variable "external_dns_role_name" {
  type        = string
  description = "Name of the IAM role for external-dns"
  default     = "eks-external-dns"
}

variable "cluster_name" {
    type        = string
    description = "Name of the EKS cluster"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace to deploy external-dns"
  default     = "kube-system"
}

variable "service_account_name" {
  type        = string
  description = "Name of the Kubernetes ServiceAccount for external-dns"
  default     = "external-dns"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}