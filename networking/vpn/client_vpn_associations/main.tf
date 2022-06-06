
resource "aws_ec2_client_vpn_network_association" "vpn_subnets" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = local.client-vpn-subnet

  security_groups = [
    aws_security_group.vpn_access.id]

  lifecycle {
    ignore_changes = [
      subnet_id]
  }
}
