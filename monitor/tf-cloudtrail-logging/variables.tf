variable "trail_name" {
  type    = string
  default = "tf-cloudtrail-trail"
}

variable "email" {
  type = string
}

locals {
  metrics = [
    {
      name      = "iam-policy-changed"
      pattern   = "{ ($.eventName = DeleteGroupPolicy) || ($.eventName = DeleteRolePolicy) }"
      namespace = "CloudTrailMetrics"
      alarm = {
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods  = 1
        period              = 300
        statistic           = "Sum"
        threshold           = 1
      }
    }
  ]
}

resource "random_uuid" "generator" {}

data "aws_caller_identity" "current" {}
