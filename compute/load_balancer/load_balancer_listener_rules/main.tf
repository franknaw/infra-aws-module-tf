
# ALB listener Rules
resource "aws_lb_listener_rule" "default" {
  count = length(var.aws_lb_listener_rules)

  listener_arn = var.aws_lb_listener_rules[count.index].listener_arn

  action {
    type             = var.aws_lb_listener_rules[count.index].action_type
    target_group_arn = var.aws_lb_listener_rules[count.index].action_target_group_arn
  }

  condition {
    path_pattern {
      values = var.aws_lb_listener_rules[count.index].condition_path_pattern_values
    }
  }
}
