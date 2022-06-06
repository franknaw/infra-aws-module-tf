
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

variable "lb_name" {
  type        = string
  description = "Load Balancer Property"
}

variable "lb_internal" {
  type        = bool
  description = "Load Balancer Property"
}

variable "lb_load_balancer_type" {
  type        = string
  description = "Load Balancer Property"
}

variable "lb_security_groups" {
  type        = list(string)
  description = "Load Balancer Property"
}

variable "lb_subnets" {
  type        = list(string)
  description = "Load Balancer Property"
}

variable "lb_enable_deletion_protection" {
  type        = bool
  description = "Load Balancer Property"
}

variable "lb_idle_timeout" {
  type        = number
  description = "Load Balancer Property"
}

variable "lb_log_bucket" {
  type        = string
  description = "Load Balancer Property"
}

variable "lb_log_prefix" {
  type        = string
  description = "Load Balancer Property"
}

variable "lb_log_enabled" {
  type        = bool
  description = "Load Balancer Property"
}

