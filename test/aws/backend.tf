terraform {
  backend "s3" {
    bucket = "deenterraformstate"
    key    = "test-aws.tfstate"
    region = "us-east-1"
  }
}
