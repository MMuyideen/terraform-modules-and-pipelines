variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to run"
  type        = string
  default     = "t3.small"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the instance"
  type        = list(string)
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Assign a public IP address to the instance"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to the instance"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data to provide when launching the instance"
  type        = string
  default     = null
}
