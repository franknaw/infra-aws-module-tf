
output "nat_gateway_gateway" {
  value       = data.aws_nat_gateway.nat_gateway_gateway
  description = "NAT Gateway"
}

output "internet_gateway_gateway" {
  value       = data.aws_internet_gateway.internet_gateway_gateway
  description = "Internet Gateway"
}

output "nat_gateway_guac" {
  value       = data.aws_nat_gateway.nat_gateway_guac
  description = "NAT Gateway"
}

output "internet_gateway_guac" {
  value       = data.aws_internet_gateway.internet_gateway_guac
  description = "Internet Gateway"
}

output "nat_gateway_range" {
  value       = data.aws_nat_gateway.nat_gateway_range
  description = "NAT Gateway"
}

output "internet_gateway_range" {
  value       = data.aws_internet_gateway.internet_gateway_range
  description = "Internet Gateway"
}

output "vpc_peering_connection_gateway_range" {
  value       = data.aws_vpc_peering_connection.vpc_peering_connection_gateway_range
  description = "Peering Connection"
}

output "vpc_peering_connection_gateway_guac" {
  value       = data.aws_vpc_peering_connection.vpc_peering_connection_gateway_guac
  description = "Peering Connection"
}

output "vpc_peering_connection_range_guac" {
  value       = data.aws_vpc_peering_connection.vpc_peering_connection_range_guac
  description = "Peering Connection"
}
