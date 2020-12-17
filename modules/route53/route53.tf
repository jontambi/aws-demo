resource "aws_route53_zone" "demo-zone" {
  name = "demosre.com"

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name = "${var.environment}-${var.vpc_name}-ROUTE53"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.demo-zone.zone_id
  name    = "www.demosre.com"
  type    = "A"
  ttl     = "300"
  records = [var.aws_eip]
}