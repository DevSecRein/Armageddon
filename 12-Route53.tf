# data "aws_route53_zone" "main" {
#   name         = "devsecrein.com"  # The domain name you want to look up
#   private_zone = false
# }

# resource "aws_route53_record" "www" {
#   zone_id = data.aws_route53_zone.main.zone_id
#   name    = "devsecrein.com"
#   type    = "A"

#   alias {
#     name                   = aws_lb.Ultramarines_SP_alb.dns_name
#     zone_id                = aws_lb.Ultramarines_SP_alb.zone_id
#     evaluate_target_health = true
#   }
# }

#Theo said not to use port 443 as of right now