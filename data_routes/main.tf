data "aws_nat_gateway" "nat_gateway_gateway" {
  tags = {
    Name = "GATEWAY-NAT-Gateway"
  }
}

data "aws_internet_gateway" "internet_gateway_gateway" {
  tags = {
    Name = "GATEWAY-Internet-Gateway"
  }
}

data "aws_nat_gateway" "nat_gateway_guac" {
  tags = {
    Name = "GUAC-NAT-Gateway"
  }
}

data "aws_internet_gateway" "internet_gateway_guac" {
  tags = {
    Name = "GUAC-Internet-Gateway"
  }
}

data "aws_internet_gateway" "internet_gateway_range" {
  tags = {
    Name = "RANGE-Internet-Gateway"
  }
}

data "aws_nat_gateway" "nat_gateway_range" {
  tags = {
    Name = "RANGE-NAT-Gateway"
  }
}

data "aws_vpc_peering_connection" "vpc_peering_connection_gateway_range" {
  tags = {
    Name = "GATEWAY-PC-GATEWAY-RANGE"
  }
}

data "aws_vpc_peering_connection" "vpc_peering_connection_gateway_guac" {
  tags = {
    Name = "GATEWAY-PC-GATEWAY-GUAC"
  }
}

data "aws_vpc_peering_connection" "vpc_peering_connection_range_guac" {
  tags = {
    Name = "RANGE-PC-RANGE-GUAC"
  }
}

