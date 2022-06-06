
resource "aws_security_group" "private" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.private_service_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.private_service_egress
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    {
      Name        = "${var.name}-Private-SG",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}

resource "aws_security_group" "public" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.public_service_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.public_service_egress
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    {
      Name        = "${var.name}-Public-SG",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}
