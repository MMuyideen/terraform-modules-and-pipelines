variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

variable "node_role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role associated with the EKS Node Group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch nodes in"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type        = string
  default     = "AL2_x86_64"
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 20
}

variable "instance_types" {
  description = "List of instance types for the node group"
  type        = list(string)
  default     = ["t3.small"]
}

variable "kubernetes_version" {
  description = "Kubernetes version for the nodes"
  type        = string
  default     = "1.31"
}

variable "labels" {
  description = "A map of Kubernetes labels to apply to the nodes"
  type        = map(string)
  default     = {}
}
