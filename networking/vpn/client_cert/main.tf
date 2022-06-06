

resource "null_resource" "gen-certs" {

  provisioner "local-exec" {
    command     = "./genCerts.sh ${var.domain_name} ${var.environment}"
    interpreter = ["sh"]
    //    working_dir = "${path.module}"
  }
}


resource "aws_acm_certificate" "default" {
  domain_name       = var.domain_name
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    {
      Name        = "${var.name}-Default-Cert",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )

  depends_on = [null_resource.gen-certs]
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = aws_acm_certificate.default.arn

  timeouts {
    create = "1m"
  }
}

resource "aws_acm_certificate" "client" {
  private_key       = file("${var.environment}/${var.private_key}")
  certificate_body  = file("${var.environment}/${var.certificate_body}")
  certificate_chain = file("${var.environment}/${var.certificate_chain}")

  tags = merge(
    {
      Name        = "${var.name}-Client-Cert",
      deployment  = var.deployment,
      environment = var.environment,
      subsystem   = var.subsystem
    },
    var.tags
  )
  depends_on = [null_resource.gen-certs]
}
