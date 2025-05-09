# ===========
# Define Route53
# ===========

resource "aws_route53_record" "apigw_record" {
  for_each = {
    for dvo in aws_acm_certificate.apigw_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

# api.itononari.xyzとAPI GW(こいつのドメインの実態はcloudfrontらしい)の紐付け
resource "aws_route53_record" "apigateway_alias" {
  zone_id = var.zone_id
  name    = "${var.api_domain}"
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.custom_domain.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.custom_domain.regional_zone_id
    evaluate_target_health = false
  }
}