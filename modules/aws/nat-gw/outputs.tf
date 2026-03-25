output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}
