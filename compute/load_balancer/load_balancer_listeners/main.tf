
# ALB listener
resource "aws_lb_listener" "default" {

  count = length(var.aws_lb_listeners)
  load_balancer_arn = var.aws_lb_listeners[count.index].load_balancer_arn
  port              = var.aws_lb_listeners[count.index].port
  protocol          = var.aws_lb_listeners[count.index].protocol
  ssl_policy        = var.aws_lb_listeners[count.index].ssl_policy
  certificate_arn   = var.aws_lb_listeners[count.index].certificate_arn

  default_action {
    type             = var.aws_lb_listeners[count.index].default_type
    target_group_arn = var.aws_lb_listeners[count.index].default_target_group_arn
  }

  tags = merge(
    {
      Name        = "${var.name}-${var.aws_lb_listeners[count.index].name}",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
}


