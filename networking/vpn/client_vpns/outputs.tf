
output "aws_lb_target_groups" {
  value = aws_ec2_client_vpn_endpoint.default.*
}