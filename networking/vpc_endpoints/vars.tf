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

variable "vpc_endpoints" {
  type = map(object({
    name                = string
    vpc_id = string
    service_name        = string
    vpc_endpoint_type   = string
    private_dns_enabled = optional(bool)
    subnet_ids          = optional(list(string))
    security_group_ids  = optional(list(string))
  }))
  description = "VPC Endpoints"
}

