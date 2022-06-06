
resource "aws_ec2_client_vpn_route" "vpn_route" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  destination_cidr_block = "10.16.4.0/22"
  target_vpc_subnet_id   = "subnet-05ceca3c853d86e6e"
  depends_on = [
    aws_ec2_client_vpn_endpoint.vpn,
    aws_ec2_client_vpn_network_association.vpn_subnets
  ]
}

