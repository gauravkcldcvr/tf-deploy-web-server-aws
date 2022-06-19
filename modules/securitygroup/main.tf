resource "aws_security_group" "lb" {

  name = "lb_security_group"
  description = "Security Group for Load Balancer"
  vpc_id = var.vpc_id

  tags = {
    Name        = "demo-lb"
    ManagedBy   = "terraform"

  }
}

resource "aws_security_group_rule" "public_out" {

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb.id
}
 
resource "aws_security_group_rule" "public_in_http" {

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb.id

lifecycle {
    create_before_destroy = true
  }
}

 
resource "aws_security_group" "app" {

  name = "app_security_group"
  description = "Security group for application"
  vpc_id = var.vpc_id

  tags = {

    Name        = "demo-app"
    Role        = "private-http"
    ManagedBy   = "terraform"

  }

}

resource "aws_security_group_rule" "private_out" {

  type                       = "egress"
  from_port                  = 0
  to_port                    = 0
  protocol                   = "-1"
  cidr_blocks                = ["0.0.0.0/0"]
  security_group_id          = aws_security_group.app.id

lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "private_in" {

  type                      = "ingress"
  from_port                 = 80
  to_port                   = 80
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.lb.id
  security_group_id         = aws_security_group.app.id

lifecycle {
    create_before_destroy = true
  }
}