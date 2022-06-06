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

variable "domain_name" {
  type        = string
  description = "Domain name for VPN cert"
}

variable "validation_method" {
  type        = string
  description = "Validation method for VPN cert"
}

variable "private_key" {
  type        = string
  description = "Private key for VPN cert"
}

variable "certificate_body" {
  type        = string
  description = "Certificate body VPN cert"
}

variable "certificate_chain" {
  type        = string
  description = "Certificate chain VPN cert"
}
