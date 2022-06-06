
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

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  type        = list(any)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  type        = list(any)
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  type = map(list(string))
  default = {
    "us-west-1" = ["us-west-1a", "us-west-1b"],
    "us-east-1" = ["us-east-1a", "us-east-1b"]
  }
  description = "List of availability zones"
}

variable "region" {
  type        = string
  description = "Region to deploy to"
}

