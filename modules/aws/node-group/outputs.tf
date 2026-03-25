output "node_group_name" {
  description = "The name of the EKS Node Group"
  value       = aws_eks_node_group.main.node_group_name
}

output "node_group_status" {
  description = "The status of the EKS Node Group"
  value       = aws_eks_node_group.main.status
}
