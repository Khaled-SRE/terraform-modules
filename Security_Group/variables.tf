
variable "security_group_name" {
  type = string
  description = "Security Group Name"
  default = "custom"

}
variable "description" {
  type        = string
  description = "Security group description. Defaults to Managed by Terraform"
  default     = "Managed by Terraform"
}
variable "vpc_id" {
  type        = string
  description = "VPC ID. Defaults to the region's default VPC."
}

variable "ingress_rules" {
  type = any
  description = "List of ingress rules with CIDR blocks or Prefix lists"
  default = []
}
variable "ingress_rules_with_source_security_group_ids" {
  type = any
  description = "List of Ingress rules with Source Security Group IDs"
  default = []
}

variable "egress_rules" {
  type = any
  description = "List of ingress rules with CIDR blocks or Prefix Lists"
  default = []
}

variable "tags" {
  description = "Optional map of tags to add to all resources"
  type        = map(string)
  default     = {}
}