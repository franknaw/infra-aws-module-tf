# Application Load Balancer.
resource "aws_lb" "default" {
  name                       = var.lb_name
  internal                   = var.lb_internal
  load_balancer_type         = var.lb_load_balancer_type
  security_groups            = var.lb_security_groups
  subnets                    = var.lb_subnets
  enable_deletion_protection = var.lb_enable_deletion_protection
  idle_timeout               = var.lb_idle_timeout

  access_logs {
    bucket  = var.lb_log_bucket
    prefix  = var.lb_log_prefix
    enabled = var.lb_log_enabled
  }

  tags = merge(
    {
      Name        = "${var.name}-${var.lb_name}",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}
