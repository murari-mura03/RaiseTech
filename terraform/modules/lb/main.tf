#--------------------------------------------------------------
# ALB
#--------------------------------------------------------------

resource "aws_lb" "lb" {
  name               = "${var.name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

#--------------------------------------------------------------
# ALB target_group
#--------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "lb_tg" {
  name     = "${var.name}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

#--------------------------------------------------------------
# ALB alb_listener
#--------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_alb_listener" "lb-http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_tg.arn
    type             = "forward"
  }
}
#--------------------------------------------------------------
# Security group
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "lb" {
  name = "${var.name}-alb-sg"

  description = "lb security group for ${var.name}"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.name}-lb-sg"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.lb.id 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "lb_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb.id
}

#--------------------------------------------------------------
# ALB lb_target_group_attachment
#--------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
resource "aws_lb_target_group_attachment" "mylb_attachment" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = var.instance_id
  port             = 80
}
