variable "env" {
  type = string
}

variable "eks_role_name" {
  type = string
}

variable "infrastructure_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "subnets_id_list" {
  type = list(any)
}

variable "esk_security_group_ids" {
  type = list(string)
}


variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "eks_addon_creation_conflict_behavior" {
  type    = string
  default = "OVERWRITE"
}

variable "eks_addon_update_conflict_behavior" {
  type    = string
  default = "PRESERVE"
}