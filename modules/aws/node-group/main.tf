resource "aws_eks_node_group" "main" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  version         = var.kubernetes_version

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = var.instance_types

  labels = var.labels

  tags = {
    Name = var.node_group_name
  }

  depends_on = []
}
