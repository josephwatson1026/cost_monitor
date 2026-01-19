provider "aws" {
  region = var.aws_region
}

module "billing_alarm_general" {
  source            = "./modules/billing_alarm"
  billing_threshold = [1, 2]
  alarm_actions     = [module.lambda_action.lambda_function_arn]
  currency          = "USD"
}

module "lambda_action" {
  source           = "./modules/lambda"
  telegram_token   = var.telegram_token
  telegram_chat_id = var.telegram_chat_id
}