
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

variable "public_service_ingress" {
  type = list(object({
    cidr_blocks = list(string)
    port        = number
    protocol    = string
    description = string
  }))
  description = "Service ingress object for public security group"
}

variable "public_service_egress" {
  type = list(object({
    cidr_blocks = list(string)
    port        = number
    protocol    = string
    description = string
  }))
  description = "Service egress object for public security group"
}

variable "private_service_ingress" {
  type = list(object({
    cidr_blocks = list(string)
    port        = number
    protocol    = string
    description = string
  }))
  description = "Service ingress object for private security group"
}

variable "private_service_egress" {
  type = list(object({
    cidr_blocks = list(string)
    port        = number
    protocol    = string
    description = string
  }))
  description = "Service egress object for private security group"
}

