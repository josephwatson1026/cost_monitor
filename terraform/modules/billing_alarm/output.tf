output "alarm_arns" {
  description = "List of billing alarm ARNs"
  value       = aws_cloudwatch_metric_alarm.create_billing_alert[*].arn
}