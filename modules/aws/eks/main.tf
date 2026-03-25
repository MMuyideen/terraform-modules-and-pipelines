resource "aws_eks_cluster" "main" {
  name            = var.project_name
  role_arn        = var.cluster_role_arn
  version         = var.kubernetes_version

  vpc_config {
    subnet_ids             = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  tags = {
    Name = var.project_name
  }

  depends_on = []
}
