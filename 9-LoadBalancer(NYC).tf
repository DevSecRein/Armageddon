resource "aws_lb" "Ultramarines_NYC_alb" {
  provider = aws.NovaYork
  name               = "Ultramarines-NYC-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Ultramarines_NYC-lb01-sg01.id]
  subnets            = [
    aws_subnet.public-us-east-1a.id,
    aws_subnet.public-us-east-1b.id
  ]
  enable_deletion_protection = false
#Lots of death and suffering here, make sure it's false

  tags = {
    Name    = "Ultramarines_Load_Balancer"
    Service = "Ultramarines"

  }
}

resource "aws_lb_listener" "http-NYC" {
  provider = aws.NovaYork
  load_balancer_arn = aws_lb.Ultramarines_NYC_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Ultramarines_NYC_tg.arn
  }
}

# data "aws_acm_certificate" "cert" {
#   domain   = "devsecrein.com"
#   statuses = ["ISSUED"]
#   most_recent = true
# }

# resource "aws_lb_listener" "https" {
#  provider = aws.NovaYork
#   load_balancer_arn = aws_lb.Ultramarines_NYC_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"  # or whichever policy suits your requirements
#   certificate_arn   = data.aws_acm_certificate.cert.arn
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.Ultramarines_SP_tg.arn
#   }
# }

output "lb_dns_name-NYC" {
  value       = aws_lb.Ultramarines_NYC_alb.dns_name
  description = "The DNS name of the Ultramarines_ Load Balancer."
}
