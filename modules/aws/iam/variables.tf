variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_service" {
  description = "The service that can assume this role (e.g., 'eks.amazonaws.com', 'ec2.amazonaws.com')"
  type        = string
}

variable "policy_arns" {
  description = "A list of IAM policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}
