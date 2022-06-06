
output "assume_role_partition" {
  value       = var.assume_role_partition
  description = "The CIDR block associated with the Private Subnets"
}

output "role_partition_ids" {
  value       = var.role_partition_ids
  description = "The CIDR block associated with the Private Subnets"
}

output "tags" {
  value       = var.tags
  description = "The CIDR block associated with the Private Subnets"
}

output "cidr_block_sub" {
  value       = var.cidr_block_sub
  description = "The CIDR block associated with the Private Subnets"
}

output "cidr_block_vpc" {
  value       = var.cidr_block_vpc
  description = "The CIDR block associated with the Private Subnets"
}

output "ip_acl" {
  value       = var.ip_acl
  description = "The IP access control list"
}

output "api_services" {
  value       = var.api_services
  description = "API Services"
}

output "route_domain" {
  value       = var.route_domain
  description = "Route 53 Domain mapping for ECS"
}

output "environment" {
  value       = var.environment
  description = "Set the environment for provisioning"
}

output "role_part_id" {
  value       = var.role_part_id
  description = "Set the environment role partition Id"
}

output "role_part" {
  value       = var.role_part
  description = "Set the environment role partition"
}

output "region" {
  value       = var.region
  description = "The CIDR block associated with the Private Subnets"
}

output "alb_base_url" {
  value       = var.alb_base_url
  description = "ALB URL"
}

output "ecr_policy" {
  value       = var.ecr_policy
  description = "IAM Role Policy for ECR"
}

output "cvle_version" {
  value       = var.cvle_version
  description = "API Versions"
}
