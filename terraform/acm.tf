resource "aws_acm_certificate" "acm_cert" {
  domain_name       = local.hostname
  validation_method = "DNS"
  tags              = local.tags
}

resource "aws_route53_record" "acm_cert_validation" {
  name            = element(tolist(aws_acm_certificate.acm_cert.domain_validation_options), 0).resource_record_name
  type            = element(tolist(aws_acm_certificate.acm_cert.domain_validation_options), 0).resource_record_type
  zone_id         = data.aws_route53_zone.route53_zone.zone_id
  records         = [element(tolist(aws_acm_certificate.acm_cert.domain_validation_options), 0).resource_record_value]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "acm_cert" {
  certificate_arn         = aws_acm_certificate.acm_cert.arn
  validation_record_fqdns = [aws_route53_record.acm_cert_validation.fqdn]
}
