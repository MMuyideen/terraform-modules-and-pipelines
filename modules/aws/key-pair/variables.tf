variable "key_name" {
  description = "The name for the key pair"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file. Either this or public_key must be provided"
  type        = string
  default     = null
}

variable "public_key" {
  description = "The public key content. Either this or public_key_path must be provided"
  type        = string
  default     = null
  sensitive   = true
}
