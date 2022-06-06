resource "aws_vpc_endpoint" "default" {
  for_each = var.vpc_endpoints

  vpc_id              = each.value.vpc_id
  service_name        = each.value.service_name
  vpc_endpoint_type   = each.value.vpc_endpoint_type
  security_group_ids  = each.value.security_group_ids
  private_dns_enabled = each.value.private_dns_enabled
  subnet_ids          = each.value.subnet_ids
  policy              = <<POLICY
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY

  tags = merge(
    {
      Name        = "${var.name}-${each.value.name}",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}
