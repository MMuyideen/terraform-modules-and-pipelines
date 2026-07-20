variable "name" {
  description = "Name of the EC2 instance, used for tagging"
  type        = string
}

variable "ami" {
  description = "AMI ID to launch the instance from"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "ID of the subnet to launch the instance in"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Name of an existing EC2 key pair to associate with the instance (optional)"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to assign a public IP address to the instance"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Size of the root EBS volume, in GiB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of the root EBS volume (e.g. gp3, gp2, io1)"
  type        = string
  default     = "gp3"
}

variable "user_data" {
  description = "User data script to run on instance launch (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to the instance"
  type        = map(string)
  default     = {}
}
