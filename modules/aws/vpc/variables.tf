variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "availability_zones" {
  description = "List of availability zones to spread subnets across. Cycled through via element() if there are more subnets than AZs."
  type        = list(string)
  default     = []
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets, one subnet created per entry"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets, one subnet created per entry"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT gateway(s) and route private subnet egress through them"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "If true, create a single NAT gateway shared by all private subnets. If false, create one NAT gateway per private subnet (higher availability, higher cost)."
  type        = bool
  default     = true
}
