

# VPC Peering
resource "aws_vpc_peering_connection" "default" {
  for_each = var.vpc_peering

  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = each.value.peer_vpc_id
  vpc_id        = each.value.vpc_id
  auto_accept   = each.value.auto_accept

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(
    {
      Name        = "${var.name}-PC-${each.value.name}",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}


//
///**
// * Route rule LMS to CRMS.
//*/
//resource "aws_route" "prod-lms-crms" {
//  route_table_id            = aws_route_table.prod-lms-private-rt.id
//  destination_cidr_block    = aws_vpc.prod-crms.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.prod-lms-peering.id
//}
//
///**
// * Route rule CRMS to LMS.
//*/
//resource "aws_route" "prod-crms-lms" {
//  route_table_id            = aws_vpc.prod-crms.main_route_table_id
//  destination_cidr_block    = aws_vpc.prod-lms.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.prod-lms-peering.id
//}
//


/**
 * Route rule Gateway to LMS.
*/
//resource "aws_route" "prod-gateway-lms" {
//  route_table_id            = aws_route_table.gateway-private-rt.id
//  destination_cidr_block    = data.aws_vpc.prod-lms.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.gateway-prod-peering.id
//}
//
//resource "aws_route" "prod-gateway-lmsb" {
//  route_table_id            = aws_route_table.gateway-public-rt.id
//  destination_cidr_block    = data.aws_vpc.prod-lms.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.gateway-prod-peering.id
//}
//
//
///**
// * Route rule to LMS to Gateway.
//*/
//resource "aws_route" "prod-lms-gateway" {
//  route_table_id            = "rtb-0c03c6054a56509b8"
//  destination_cidr_block    = aws_vpc.gateway.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.gateway-prod-peering.id
//}

//resource "aws_route" "prod-lms-gatewayb" {
//  route_table_id            = "rtb-001ef8e2f9b0e00f2"
//  destination_cidr_block    = aws_vpc.gateway.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.gateway-prod-peering.id
//}


//resource "aws_route" "prod-gateway-lms-p" {
//  route_table_id            = aws_route_table.gateway-public-rt.id
//  destination_cidr_block    = data.aws_vpc.prod-lms.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.gateway-prod-peering.id
//}
