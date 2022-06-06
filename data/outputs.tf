
output "vpc_gateway" {
  value       = data.aws_vpc.vpc_gateway
  description = "The CIDR block associated with the VPC"
}

output "vpc_gateway_subs_private_cidr_blocks" {
  value = [for s in data.aws_subnet.vpc_gateway_subs_private : s.cidr_block]
  description = "The CIDR block associated with the Private Subnets"
}

output "vpc_gateway_subs_private" {
  value = [for s in data.aws_subnet.vpc_gateway_subs_private : s.id]
  description = "The subnet ids associated with the Private Subnets"
}


output "vpc_gateway_subs_public_cidr_blocks" {
  value = [for s in data.aws_subnet.vpc_gateway_subs_public : s.cidr_block]
  description = "The CIDR block associated with the Public Subnets"
}

output "vpc_gateway_subs_public" {
  value = [for s in data.aws_subnet.vpc_gateway_subs_public : s.id]
  description = "The subnet ids associated with the Public Subnets"
}

output "vpc_range" {
  value       = data.aws_vpc.vpc_range
  description = "The CIDR block associated with the VPC"
}

output "vpc_range_subs_private_cidr_blocks" {
  value = [for s in data.aws_subnet.vpc_range_subs_private : s.cidr_block]
  description = "The CIDR block associated with the Private Subnets"
}

output "vpc_range_subs_private" {
  value = [for s in data.aws_subnet.vpc_range_subs_private : s.id]
  description = "The subnet ids associated with the Private Subnets"
}

output "vpc_range_subs_public_cidr_blocks" {
  value = [for s in data.aws_subnet.vpc_range_subs_public : s.cidr_block]
  description = "The CIDR block associated with the Public Subnets"
}

output "vpc_range_subs_public" {
  value = [for s in data.aws_subnet.vpc_range_subs_public : s.id]
  description = "The subnet ids associated with the Public Subnets"
}


output "vpc_guac" {
  value       = data.aws_vpc.vpc_guac
  description = "The CIDR block associated with the VPC"
}

output "vpc_guac_subs_private_cidr_blocks" {
  value = [for s in data.aws_subnet.vpc_guac_subs_private : s.cidr_block]
  description = "The CIDR block associated with the Private Subnets"
}

output "vpc_guac_subs_private" {
  value = [for s in data.aws_subnet.vpc_guac_subs_private : s.id]
  description = "The subnet ids associated with the Private Subnets"
}

output "vpc_guac_subs_public_cidr_blocks" {
  value = [for s in data.aws_subnet.vpc_guac_subs_public : s.cidr_block]
  description = "The CIDR block associated with the Public Subnets"
}

output "vpc_guac_subs_public" {
  value = [for s in data.aws_subnet.vpc_guac_subs_public : s.id]
  description = "The subnet ids associated with the Public Subnets"
}
