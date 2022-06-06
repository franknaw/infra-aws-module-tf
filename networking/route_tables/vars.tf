terraform {
  # Optional attributes and the defaults function are
  # both experimental, so we must opt in to the experiment.
  experiments = [module_variable_optional_attrs]
}

variable "name" {
  type        = string
  description = "Base Name of the infra"
}

variable "deployment" {
  type        = string
  description = "Name of deployment this resource is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this resource is targeting"
}

variable "subsystem" {
  type        = string
  description = "Name of subsystem this resource is supporting"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the resource"
}

variable "vpc_id" {
  type        = string
  description = "VPC Id"
}

variable "private_routes" {
  type = list(object({
    cidr_block                 = optional(string)
    nat_gateway_id             = optional(string)
    vpc_peering_connection_id  = optional(string)
    ipv6_cidr_block            = optional(string)
    egress_only_gateway_id     = optional(string)
    carrier_gateway_id         = optional(string)
    destination_prefix_list_id = optional(string)
    gateway_id                 = optional(string)
    instance_id                = optional(string)
    local_gateway_id           = optional(string)
    network_interface_id       = optional(string)
    transit_gateway_id         = optional(string)
    vpc_endpoint_id            = optional(string)
  }))
  default     = [{ cidr_block = "0.0.0.0/0" }]
  description = "Route entries for private route table"
}

variable "public_routes" {
  type = list(object({
    cidr_block                 = optional(string)
    nat_gateway_id             = optional(string)
    vpc_peering_connection_id  = optional(string)
    ipv6_cidr_block            = optional(string)
    egress_only_gateway_id     = optional(string)
    carrier_gateway_id         = optional(string)
    destination_prefix_list_id = optional(string)
    gateway_id                 = optional(string)
    instance_id                = optional(string)
    local_gateway_id           = optional(string)
    network_interface_id       = optional(string)
    transit_gateway_id         = optional(string)
    vpc_endpoint_id            = optional(string)
  }))
  default     = [{ cidr_block = "0.0.0.0/0" }]
  description = "Route entries for public route table"
}
