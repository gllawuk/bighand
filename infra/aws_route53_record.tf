resource "aws_route53_record" "gregglatchams_com_pip_vmweb1_1" {
  zone_id = data.aws_route53_zone.gregglatchams_com.id
  name    = "pip-vmweb1-1.gregglatchams.com"
  type    = "A"
  ttl     = "300"
  records = [azurerm_public_ip.pip_vmweb1_1.ip_address]
}

resource "aws_route53_record" "gregglatchams_com_bighand" {
  zone_id = data.aws_route53_zone.gregglatchams_com.id
  name    = "bighand.gregglatchams.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_route53_record.gregglatchams_com_pip_vmweb1_1.fqdn]
}