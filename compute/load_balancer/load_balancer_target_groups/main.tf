
# Target Groups
resource "aws_lb_target_group" "default" {
  count = length(var.aws_lb_tg)

  name                          = var.aws_lb_tg[count.index].name
  port                          = var.aws_lb_tg[count.index].port
  protocol                      = var.aws_lb_tg[count.index].protocol
  vpc_id                        = var.aws_lb_tg[count.index].vpc_id
  load_balancing_algorithm_type = var.aws_lb_tg[count.index].load_balancing_algorithm_type
  target_type                   = var.aws_lb_tg[count.index].target_type

  stickiness {
    enabled = var.aws_lb_tg[count.index].stickiness_enabled
    type    = var.aws_lb_tg[count.index].stickiness_type
  }

  health_check {
    protocol = var.aws_lb_tg[count.index].health_check_protocol
    path     = var.aws_lb_tg[count.index].health_check_path
    matcher  = var.aws_lb_tg[count.index].health_check_matcher
    port     = var.aws_lb_tg[count.index].health_check_port
    timeout  = var.aws_lb_tg[count.index].health_check_timeout
    interval = var.aws_lb_tg[count.index].health_check_interval
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    {
      Name        = "${var.name}-${var.aws_lb_tg[count.index].name}-TG",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}
