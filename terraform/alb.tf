resource "aws_security_group" "alb_sg" {

  name        = "${local.name_prefix}-alb-sg"
  description = "Security group of ALB for customer ${var.owner} amd environment ${var.env}"
  vpc_id      = data.aws_vpc.default.id

  # Public 443 port
  dynamic "ingress" {
    for_each = var.private_deploy ? [] : [true]
    content {
      from_port = "443"
      to_port   = "443"
      protocol  = "tcp"

      cidr_blocks = [
        "0.0.0.0/0",
      ]
    }
  }

  # Private 443 port
  dynamic "ingress" {
    for_each = var.private_deploy ? [true] : []
    content {
      from_port = "443"
      to_port   = "443"
      protocol  = "tcp"

      cidr_blocks = [
        var.private_cidr
      ]
    }
  }

  # Public 80 port
  dynamic "ingress" {
    for_each = var.private_deploy ? [] : [true]
    content {
      from_port = "80"
      to_port   = "80"
      protocol  = "tcp"

      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  }

  # Private 80 port
  dynamic "ingress" {
    for_each = var.private_deploy ? [true] : []
    content {
      from_port = "80"
      to_port   = "80"
      protocol  = "tcp"

      cidr_blocks = [
        var.private_cidr
      ]
    }
  }

  egress {
    from_port = var.service_service_port
    protocol  = "tcp"
    to_port   = var.service_service_port

    security_groups = [
      module.service.service_instance_sg_id
    ]
  }

  tags = local.tags
}

resource "aws_lb" "alb" {
  name               = local.name_prefix
  internal           = var.private_deploy
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets                    = tolist(data.aws_subnet_ids.subnets.ids)
  enable_deletion_protection = false
  tags                       = local.tags
}

resource "aws_lb_listener" "default_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.acm_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = module.service.service_target_group_arn
  }

}

resource "aws_lb_listener" "default_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}