resource "aws_sns_topic" "cloudtrail_alerts" {
  name = "cloudtrail-alerts"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.cloudtrail_alerts.arn
  protocol  = "email"
  endpoint  = var.email
}

resource "aws_cloudwatch_metric_alarm" "metric_alarms" {
  for_each = { for m in local.metrics : m.name => m }

  alarm_name          = "${each.value.name}-alarm"
  alarm_description   = "CloudTrail alarm: ${each.value.name}"
  metric_name         = each.value.name
  namespace           = each.value.namespace
  statistic           = each.value.alarm.statistic
  period              = each.value.alarm.period
  evaluation_periods  = each.value.alarm.evaluation_periods
  threshold           = each.value.alarm.threshold
  comparison_operator = each.value.alarm.comparison_operator
  alarm_actions       = [aws_sns_topic.cloudtrail_alerts.arn]
}