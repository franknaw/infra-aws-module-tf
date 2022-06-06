output "vpc_id" {
  value       = aws_vpc.default.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = aws_subnet.public.*.id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = aws_subnet.private.*.id
  description = "List of private subnet IDs"
}

output "vpc_cidr_block" {
  value       = var.vpc_cidr_block
  description = "The CIDR block associated with the VPC"
}

output "private_cidr_blocks" {
  value       = var.private_subnet_cidr_blocks
  description = "The CIDR block associated with the Private Subnets"
}

output "public_cidr_blocks" {
  value       = var.public_subnet_cidr_blocks
  description = "The CIDR block associated with the Public Subnets"
}



