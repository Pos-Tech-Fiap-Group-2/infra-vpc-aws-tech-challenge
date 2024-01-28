resource "aws_lb" "tech-challenge-lb" {
  count              = var.nlb_enabled ? 1 : 0
  name               = var.lb_name
  security_groups    = [aws_security_group.tech-challenge-alb-sg.id]
  load_balancer_type = "application"

  subnets = [aws_subnet.tech-challenge-subnet["pub_a"].id, aws_subnet.tech-challenge-subnet["pub_b"].id]

  tags = merge(local.common_tags, {
    Name = "tech-challenge-lb"
  })
}

resource "aws_lb_target_group" "tech-challenge-lb-tg" {
  name        = var.lb_tg_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.tech-challenge-vpc.id

  health_check {
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200,301,302"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
  }

  tags = merge(local.common_tags, {
    Name = "tech-challenge-lb-tg"
  })

}

resource "aws_lb_listener" "tech-challenge-lb-listener" {
  load_balancer_arn = aws_lb.tech-challenge-lb[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tech-challenge-lb-tg.arn
  }

  depends_on = [aws_lb.tech-challenge-lb]
}

resource "aws_security_group" "tech-challenge-alb-sg" {
  name        = var.alb_sg_name
  description = "SG-ALB-Tech-Challenge"

  vpc_id = aws_vpc.tech-challenge-vpc.id

  dynamic "ingress" {
    for_each = var.nlb_enabled ? [1] : []
    content {
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = var.cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.nlb_enabled ? [1] : []
    content {
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_blocks = var.cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.nlb_enabled ? [1] : []
    content {
      protocol    = "tcp"
      from_port   = 8080
      to_port     = 8080
      cidr_blocks = var.cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.nlb_enabled ? [1] : []
    content {
      protocol    = "tcp"
      from_port   = 3306
      to_port     = 3306
      cidr_blocks = var.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }

  tags = merge(local.common_tags, {
    Name = "tech-challenge-alb-sg"
  })
}
