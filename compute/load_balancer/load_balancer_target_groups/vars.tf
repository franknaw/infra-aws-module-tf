
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

variable "aws_lb_tg" {
  type = list(object({
    name                          = string
    port                          = number
    protocol                      = string
    vpc_id                        = string
    load_balancing_algorithm_type = string
    target_type                   = string
    stickiness_enabled            = bool
    stickiness_type               = string
    health_check_protocol         = string
    health_check_path             = string
    health_check_matcher          = string
    health_check_port             = string
    health_check_timeout          = number
    health_check_interval         = number
  }))
  description = "Target Groups"
}
