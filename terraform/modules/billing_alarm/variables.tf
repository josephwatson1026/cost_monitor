variable "billing_threshold" {
  description = "The threshold for monthly charges in USD"
  type = list(number)
  default = [1,10,50,100,500]
}

variable "currency" {
  description = "The currency used for calculation"
  type = string
  default = "USD"
}