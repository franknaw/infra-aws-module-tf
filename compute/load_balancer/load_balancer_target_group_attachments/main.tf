
resource "aws_lb_target_group_attachment" "default" {
  count = length(var.aws_lb_tg_attachment)

  target_group_arn  = var.aws_lb_tg_attachment[count.index].target_group_arn
  target_id         = var.aws_lb_tg_attachment[count.index].attachment_target_id
  port              = var.aws_lb_tg_attachment[count.index].attachment_port
  availability_zone = var.aws_lb_tg_attachment[count.index].attachment_availability_zone
}
