
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

variable "aws_lb_listener_rules" {
  type = list(object({
    name                          = string
    listener_arn                  = string
    action_type                   = string
    action_target_group_arn       = string
    condition_path_pattern_values = list(string)
  }))
  description = "ALB Listeners Rules"
}


