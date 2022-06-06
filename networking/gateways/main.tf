# Internet Gateway
resource "aws_internet_gateway" "default" {
  vpc_id = var.vpc_id

  tags = merge(
  {
    Name        = "${var.name}-Internet-Gateway",
    deployment  = var.deployment,
    environment = var.environment,
    subsystem   = var.subsystem
  },
  var.tags
  )
}

# Nat Gateway
resource "aws_eip" "nat" {
  vpc   = true
  tags = merge(
  {
    Name        = "${var.name}-NAT-Gateway-EIP",
    deployment  = var.deployment,
    environment = var.environment,
    subsystem   = var.subsystem
  },
  var.tags
  )
}

resource "aws_nat_gateway" "default" {
  depends_on        = [aws_internet_gateway.default]
  connectivity_type = "public"
  allocation_id     = aws_eip.nat.id
  subnet_id         = var.public_subnet_id

  tags = merge(
  {
    Name        = "${var.name}-NAT-Gateway",
    deployment  = var.deployment,
    environment = var.environment,
    subsystem   = var.subsystem
  },
  var.tags
  )
}
