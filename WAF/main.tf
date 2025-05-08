resource "aws_wafv2_web_acl" "main" {
  name        = var.waf_name
  description = var.waf_description
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = var.waf_rules
    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.statement.managed_rule_group_statement.name
          vendor_name = rule.value.statement.managed_rule_group_statement.vendor_name

          dynamic "rule_action_override" {
            for_each = rule.value.statement.managed_rule_group_statement.rule_action_overrides != null ? rule.value.statement.managed_rule_group_statement.rule_action_overrides : []
            content {
              name = rule_action_override.value.name
              action_to_use {
                allow {}
              }
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value.visibility_config.cloudwatch_metrics_enabled
        metric_name               = rule.value.visibility_config.metric_name
        sampled_requests_enabled  = rule.value.visibility_config.sampled_requests_enabled
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name               = "WAFWebACLMetric"
    sampled_requests_enabled  = true
  }

  tags = merge(
    var.tags,
    {
      Name = var.waf_name
    }
  )
}

resource "aws_wafv2_web_acl_association" "main" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.main.arn
}

# CloudWatch Log Group for WAF
resource "aws_cloudwatch_log_group" "waf_logs" {
  name              = "/aws/waf/${var.waf_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

# CloudWatch Metric Alarm for WAF Blocked Requests
resource "aws_cloudwatch_metric_alarm" "waf_blocked_requests" {
  count               = var.enable_blocked_requests_alarm ? 1 : 0
  alarm_name          = "${var.waf_name}-blocked-requests"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "BlockedRequests"
  namespace           = "AWS/WAFV2"
  period             = "300"
  statistic          = "Sum"
  threshold          = var.blocked_requests_threshold
  alarm_description  = "This metric monitors the number of requests blocked by WAF"
  alarm_actions      = var.alarm_actions

  dimensions = {
    WebACL = var.waf_name
    Region = data.aws_region.current.name
  }

  tags = var.tags
}

# Get current AWS region
data "aws_region" "current" {} 