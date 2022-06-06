
data "aws_vpc" "vpc_gateway" {
  filter {
    name = "tag:Name"
    values = [
    "GATEWAY-VPC"]
  }
}

data "aws_subnet_ids" "vpc_gateway_subs_private_ids" {
  vpc_id = data.aws_vpc.vpc_gateway.id
  tags = {
    Tier = "GATEWAY-Private"
  }
}

data "aws_subnet" "vpc_gateway_subs_private" {
  for_each = data.aws_subnet_ids.vpc_gateway_subs_private_ids.ids
  id       = each.value
}

data "aws_subnet_ids" "vpc_gateway_subs_public_ids" {
  vpc_id = data.aws_vpc.vpc_gateway.id
  tags = {
    Tier = "GATEWAY-Public"
  }
}

data "aws_subnet" "vpc_gateway_subs_public" {
  for_each = data.aws_subnet_ids.vpc_gateway_subs_public_ids.ids
  id       = each.value
}

data "aws_vpc" "vpc_range" {
  filter {
    name = "tag:Name"
    values = [
    "RANGE-VPC"]
  }
}

data "aws_subnet_ids" "vpc_range_subs_private_ids" {
  vpc_id = data.aws_vpc.vpc_range.id
  tags = {
    Tier = "RANGE-Private"
  }
}

data "aws_subnet" "vpc_range_subs_private" {
  for_each = data.aws_subnet_ids.vpc_range_subs_private_ids.ids
  id       = each.value
}


data "aws_subnet_ids" "vpc_range_subs_public_ids" {
  vpc_id = data.aws_vpc.vpc_range.id
  tags = {
    Tier = "RANGE-Public"
  }
}

data "aws_subnet" "vpc_range_subs_public" {
  for_each = data.aws_subnet_ids.vpc_range_subs_public_ids.ids
  id       = each.value
}

data "aws_vpc" "vpc_guac" {
  filter {
    name = "tag:Name"
    values = [
    "GUAC-VPC"]
  }
}

data "aws_subnet_ids" "vpc_guac_subs_private_ids" {
  vpc_id = data.aws_vpc.vpc_guac.id
  tags = {
    Tier = "GUAC-Private"
  }
}

data "aws_subnet" "vpc_guac_subs_private" {
  for_each = data.aws_subnet_ids.vpc_guac_subs_private_ids.ids
  id       = each.value
}


data "aws_subnet_ids" "vpc_guac_subs_public_ids" {
  vpc_id = data.aws_vpc.vpc_guac.id
  tags = {
    Tier = "GUAC-Public"
  }
}

data "aws_subnet" "vpc_guac_subs_public" {
  for_each = data.aws_subnet_ids.vpc_guac_subs_public_ids.ids
  id       = each.value
}
