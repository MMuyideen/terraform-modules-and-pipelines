terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

resource "random_string" "this" {
  length  = var.length
  special = false
  upper   = var.upper
  numeric = var.numeric
}
