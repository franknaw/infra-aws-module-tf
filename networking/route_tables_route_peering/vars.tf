

variable "private_subnet_cidr" {
  type = list(string)
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_route_table_id" {
  type = string
}

variable "public_route_table_id" {
  type = string
}

variable "vpc_peering_id" {
  type = string
}
