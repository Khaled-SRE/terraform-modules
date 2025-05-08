variable "eks_alb_role_arn" {
  description = "ARN of the IAM role for the AWS Load Balancer Controller"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace to deploy the AWS Load Balancer Controller"
  type        = string
  default     = "kube-system"
}

variable "chart_version" {
  description = "Version of the AWS Load Balancer Controller Helm chart"
  type        = string
  default     = "1.4.8"
}

variable "aws_region" {
  description = "AWS region where the EKS cluster is deployed"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster is deployed"
  type        = string
}

variable "replica_count" {
  description = "Number of AWS Load Balancer Controller replicas"
  type        = number
  default     = 2
}

variable "resources_requests_cpu" {
  description = "CPU request for the AWS Load Balancer Controller"
  type        = string
  default     = "0.25"
}

variable "resources_requests_memory" {
  description = "Memory request for the AWS Load Balancer Controller"
  type        = string
  default     = "256Mi"
}

variable "resources_limits_cpu" {
  description = "CPU limit for the AWS Load Balancer Controller"
  type        = string
  default     = "0.5"
}

variable "resources_limits_memory" {
  description = "Memory limit for the AWS Load Balancer Controller"
  type        = string
  default     = "512Mi"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable addon_depends_on_nodegroup_no_taint {
  type = string
}