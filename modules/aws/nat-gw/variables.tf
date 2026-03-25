variable "subnet_id" {
  description = "The public subnet ID where the NAT Gateway will be placed"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs to route through the NAT Gateway"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the NAT Gateway and route table will be created"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
