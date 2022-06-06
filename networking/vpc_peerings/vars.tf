
data "aws_caller_identity" "current" {}

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

variable "vpc_peering" {
  type = map(object({
    name        = string
    vpc_id      = string
    peer_vpc_id = string
    auto_accept = bool
  }))
  description = "VPC Peering"
}
