
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

variable "client_vpn_endpoint" {
  type = list(object({
    name                                      = string
    description                               = string
    client_cidr_block                         = string
    split_tunnel                              = bool
    server_certificate_arn                    = string
    authentication_type                       = string
    authentication_root_certificate_chain_arn = string
    connection_log_enabled                    = bool
  }))
  description = "Client VPN Endpoint"
}

