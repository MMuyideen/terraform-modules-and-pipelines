locals {
  public_key = var.public_key != null ? var.public_key : (
    var.public_key_path != null ? file(var.public_key_path) : null
  )
}

resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = local.public_key

  tags = {
    Name = var.key_name
  }
}
