# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.private_routes
    content {
      cidr_block                = route.value.cidr_block
      nat_gateway_id            = route.value.nat_gateway_id
      vpc_peering_connection_id = route.value.vpc_peering_connection_id
    }
  }

  tags = merge(
    {
      Name        = "${var.name}-Private-RT",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.public_routes
    content {
      cidr_block                = route.value.cidr_block
      gateway_id            = route.value.gateway_id
      vpc_peering_connection_id = route.value.vpc_peering_connection_id
    }
  }

  tags = merge(
    {
      Name        = "${var.name}-Public-RT",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}
