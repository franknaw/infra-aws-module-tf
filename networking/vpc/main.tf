# VPC
resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = merge(
    {
      Name        = "${var.name}-VPC",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}

# Subnets Private
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[var.region][count.index]

  tags = merge(
    {
      Name        = "${var.name}-Private-Subnet-${count.index + 1}",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
      Tier = "${var.name}-Private"
    },
    var.tags
  )
}

# Subnets Public
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[var.region][count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = "${var.name}-Public-Subnet-${count.index + 1}",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
      Tier = "${var.name}-Public"
    },
    var.tags
  )
}

