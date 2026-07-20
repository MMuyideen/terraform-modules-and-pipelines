output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "List of NAT gateway IDs"
  value       = module.vpc.nat_gateway_ids
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.id
}

output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = module.ec2.public_ip
}
