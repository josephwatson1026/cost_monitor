variable "telegram_token" {
  description = "The API token for the Telegram bot"
  type        = string
  sensitive   = true
}

variable "telegram_chat_id" {
  description = "The chat ID to send messages to"
  type        = string
}