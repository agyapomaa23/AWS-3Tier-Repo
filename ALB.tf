# Creating target group
resource "aws_lb_target_group" "Target-group" {
  health_check {
    interval            = 200
    path                = "/"
    protocol            = "HTTP"
    timeout             = 60
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  name        = "3tier-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "3tier-alb-tg"
  }
}


#Creating ALB
resource "aws_lb" "application-lb" {
  name                       = "3-tier-alb"
  internal                   = false
  ip_address_type            = "ipv4"
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sec-group.id]
  subnets                    = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection = false

  tags = {
    name = "3-tier-alb"
  }
}


# Creating listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Target-group.arn
  }
}


#Creating Target group and EC2 attachment
resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.Target-group.arn
  target_id        = aws_instance.Test-server1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_attach2" {
  target_group_arn = aws_lb_target_group.Target-group.arn
  target_id        = aws_instance.Test-server2.id
  port             = 80
}