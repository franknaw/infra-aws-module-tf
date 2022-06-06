
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

variable "aws_lb_tg_attachment" {
  type = list(object({
    target_group_arn             = string
    attachment_target_id         = string
    attachment_port              = number
    attachment_availability_zone = string
  }))
  description = "Target Group Attachments"
}
