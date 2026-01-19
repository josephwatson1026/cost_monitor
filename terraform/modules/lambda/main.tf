data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file = "${path.module}/lamda_files/alert_telegram_lambda.py"
    output_path = "${path.module}/lamda_files/alert_telegram_lambda.zip"
}

resource "aws_lambda_function" "alert_telegram_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "alert_telegram_lambda"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "alert_telegram_lambda.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  runtime          = "python3.9"
  environment {
    variables = {
      TELEGRAM_TOKEN   = var.telegram_token
      TELEGRAM_CHAT_ID = var.telegram_chat_id
    }
  }
}


resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatchAlarms"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.alert_telegram_lambda.function_name
  principal     = "lambda.alarms.cloudwatch.amazonaws.com"
}

# 4. IAM Role for Lambda (Standard execution role)
resource "aws_iam_role" "lambda_exec" {
  name = "billing_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}
