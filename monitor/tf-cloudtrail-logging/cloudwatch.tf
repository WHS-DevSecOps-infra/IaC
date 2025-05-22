resource "aws_cloudwatch_log_group" "cloudtrail_log_group" {
  name = "cloudtrail-log-group"
  retention_in_days = 1 // 로그 저장 기간 설정. 나중에 실제 프젝할 때는 기간 늘려주기
}

resource "aws_cloudwatch_log_metric_filter" "trail_metrics" {
  for_each       = { for m in local.metrics : m.name => m }
  name           = each.value.name
  log_group_name = aws_cloudwatch_log_group.cloudtrail_log_group.name
  pattern        = each.value.pattern

  metric_transformation {
    name      = each.value.name
    namespace = each.value.namespace
    value     = "1"
  }
}