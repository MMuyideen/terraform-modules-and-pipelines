variable "project_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Amazon EKS control plane to make calls to AWS API operations"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch the cluster in"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version"
  type        = string
  default     = "1.31"
}

variable "endpoint_private_access" {
  description = "Enable private API server endpoint"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
  default     = true
}
