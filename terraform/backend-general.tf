terraform {
  backend "s3" {
    bucket         = "tf-state-dev-016714367715"
    key            = "billing-alarm/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
