# Route Table peering for Private Subnets
resource "aws_route" "private" {
  count = length(var.private_subnet_cidr)
  route_table_id = var.private_route_table_id
  destination_cidr_block    = var.private_subnet_cidr[count.index]
  vpc_peering_connection_id = var.vpc_peering_id
}

# Route Table peering for Public Subnets
resource "aws_route" "public" {
  count = length(var.public_subnet_cidr)
  route_table_id = var.public_route_table_id
  destination_cidr_block    = var.public_subnet_cidr[count.index]
  vpc_peering_connection_id = var.vpc_peering_id
}

