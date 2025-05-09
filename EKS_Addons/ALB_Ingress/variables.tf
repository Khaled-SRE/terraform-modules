variable "eks_alb_role_arn" {
  description = "ARN of the IAM role for the AWS Load Balancer Controller"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = "1.5.4"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "addon_depends_on_nodegroup_no_taint" {
  type = string
}