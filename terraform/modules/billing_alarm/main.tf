resource "aws_cloudwatch_metric_alarm" "create_billing_alert" {
  count = length(var.billing_threshold)
  alarm_name = "Billing_Alarm_${var.billing_threshold[count.index]}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "EstimatedCharges"
  period = "21600"
  statistic = "Maximum"
  namespace = "AWS/Billing"
  alarm_description = "This alarm monitors the total estimated AWS charges for threshold ${var.billing_threshold[count.index]} ${var.currency}"
  dimensions = {
    Currency = "${var.currency}"
  }
}

