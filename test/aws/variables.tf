# -------------------
# VPC
# -------------------

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to spread subnets across"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT gateway(s) for private subnet egress"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "If true, share a single NAT gateway across all private subnets instead of one per subnet"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
