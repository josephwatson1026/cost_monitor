output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.alert_telegram_lambda.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.alert_telegram_lambda.function_name
}