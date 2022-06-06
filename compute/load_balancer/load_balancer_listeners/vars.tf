
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

variable "aws_lb_listeners" {
  type = list(object({
    name                     = string
    load_balancer_arn        = string
    port                     = string
    protocol                 = string
    ssl_policy               = optional(string)
    certificate_arn          = optional(string)
    default_type             = string
    default_target_group_arn = string
  }))
  description = "ALB Listeners"
}

