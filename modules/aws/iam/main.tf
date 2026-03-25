data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [var.assume_role_service]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "main" {
  name              = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name = var.role_name
  }
}

resource "aws_iam_role_policy_attachment" "main" {
  for_each = toset(var.policy_arns)

  role       = aws_iam_role.main.name
  policy_arn = each.value
}
