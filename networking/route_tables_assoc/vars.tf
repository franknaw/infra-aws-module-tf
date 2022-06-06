

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_route_table_id" {
  type = string
}

variable "public_route_table_id" {
  type = string
}

