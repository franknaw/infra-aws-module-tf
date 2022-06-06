
resource "aws_ec2_client_vpn_endpoint" "default" {
  count = length(var.client_vpn_endpoint)

  description            = var.client_vpn_endpoint[count.index].description
  client_cidr_block      = var.client_vpn_endpoint[count.index].client_cidr_block
  split_tunnel           = var.client_vpn_endpoint[count.index].split_tunnel
  server_certificate_arn = var.client_vpn_endpoint[count.index].server_certificate_arn

  authentication_options {
    type                       = var.client_vpn_endpoint[count.index].authentication_type
    root_certificate_chain_arn = var.client_vpn_endpoint[count.index].authentication_root_certificate_chain_arn
  }

  connection_log_options {
    enabled = var.client_vpn_endpoint[count.index].connection_log_enabled
  }

  tags = merge(
    {
      Name        = "${var.name}-${var.client_vpn_endpoint[count.index].name}",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}
