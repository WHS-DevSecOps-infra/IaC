resource "aws_cloudtrail" "cloudtrail" {
  name                          = var.trail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_logs_role.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail_log_group.arn}:*"

  event_selector {
    read_write_type = "All"
  }

  depends_on = [
    aws_cloudwatch_log_group.cloudtrail_log_group,
    aws_s3_bucket_policy.cloudtrail_policy
  ]
}