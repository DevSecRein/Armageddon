resource "aws_lb_target_group" "Ultramarines_SP_tg" {
  name     = "Ultramarines-SP-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Ultramarines_Sao_Paulo_VPC.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "Ultramarines_SP-TargetGroup"
    Project = "Armageddon"
  }
}

#------------------------------------------

#NYC
resource "aws_lb_target_group" "Ultramarines_NYC_tg" {
  provider = aws.NovaYork
  name     = "Ultramarines-NYC-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Ultramarines_NYC_VPC.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "Ultramarines_NYC-TargetGroup"
    Project = "Armageddon"
  }
}

#London
resource "aws_lb_target_group" "Ultramarines_LDN_tg" {
  provider = aws.Londres
  name     = "Ultramarines-London-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Ultramarines_London_VPC.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "Ultramarines_London-TargetGroup"
    Project = "Armageddon"
  }
}