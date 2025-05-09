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
  default     = "1.4.8"
}

variable "aws_region" {
  description = "AWS region for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC for the EKS cluster"
  type        = string
}

variable "replica_count" {
  description = "Number of replicas"
  type        = number
  default     = 2
}

variable "resources_requests_cpu" {
  description = "CPU request for the controller"
  type        = string
  default     = "0.5"
}

variable "resources_requests_memory" {
  description = "Memory request for the controller"
  type        = string
  default     = "512Mi"
}

variable "resources_limits_cpu" {
  description = "CPU limit for the controller"
  type        = string
  default     = "1"
}

variable "resources_limits_memory" {
  description = "Memory limit for the controller"
  type        = string
  default     = "1Gi"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable addon_depends_on_nodegroup_no_taint {
  type = string
}