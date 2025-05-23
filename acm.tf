# ===========
# Define AWS Certification Manager
# ===========


resource "aws_acm_certificate" "apigw_cert" {
  domain_name       = "${var.api_domain}"
  validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
}


resource "aws_acm_certificate_validation" "apigw_cert_valid" {
  certificate_arn         = aws_acm_certificate.apigw_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.apigw_record : record.fqdn]
}

