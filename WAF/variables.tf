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
    name     = string
    priority = number
    statement = object({
      managed_rule_group_statement = object({
        name        = string
        vendor_name = string
        rule_action_overrides = optional(list(object({
          name = string
        })))
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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "Number of days to retain WAF logs in CloudWatch"
  type        = number
  default     = 30
}

variable "enable_blocked_requests_alarm" {
  description = "Whether to enable CloudWatch alarm for blocked requests"
  type        = bool
  default     = true
}

variable "blocked_requests_threshold" {
  description = "Threshold for blocked requests alarm"
  type        = number
  default     = 100
}

variable "alarm_actions" {
  description = "List of ARNs to notify when the alarm is triggered"
  type        = list(string)
  default     = []
} 
