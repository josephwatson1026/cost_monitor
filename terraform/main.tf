provider "aws" {
  region = var.aws_region
}

module "billing_alarm_general" {
  source = "./modules/billing_alarm"
  billing_threshold = [1,2]
}