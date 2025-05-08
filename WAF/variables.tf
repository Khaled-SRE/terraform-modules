variable "waf_name" {
  description = "Name of the WAF web ACL"
  type        = string
}

variable "waf_description" {
  description = "Description of the WAF web ACL"
  type        = string
}

variable "waf_rules" {
  description = "List of WAF rules to apply"
  type = list(object({
    name        = string
    priority    = number
    override_action = string
    statement = object({
      managed_rule_group_statement = object({
        name        = string
        vendor_name = string
      })
    })
    visibility_config = object({
      cloudwatch_metrics_enabled = bool
      metric_name               = string
      sampled_requests_enabled  = bool
    })
  }))
}

variable "alb_arn" {
  description = "ARN of the ALB to associate with the WAF web ACL"
  type        = string
} 
