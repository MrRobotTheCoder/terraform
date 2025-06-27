# AWS Route53 DNS Registration

# DNS Registration
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "cloudwatch.hellosaanvika.com"
  type    = "A"
  
  alias {
    name                   = module.nlb.dns_name
    zone_id                = module.nlb.zone_id
    evaluate_target_health = true
  }
}