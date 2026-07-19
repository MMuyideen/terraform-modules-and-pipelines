variable "length" {
  description = "The length of the random string to generate"
  type        = number
  default     = 4
}

variable "upper" {
  description = "Whether to include uppercase letters in the random string"
  type        = bool
  default     = false
}

variable "numeric" {
  description = "Whether to include numeric digits in the random string"
  type        = bool
  default     = true
}
