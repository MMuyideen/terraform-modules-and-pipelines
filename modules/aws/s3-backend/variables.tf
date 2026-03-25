variable "bucket_name" {
  description = "The name of the S3 bucket for Terraform backend"
  type        = string
}

variable "region" {
  description = "The AWS region where the bucket will be created"
  type        = string
}
