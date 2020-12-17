resource "aws_route53_zone" "demo-zone" {
  name = "demosre.com"

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name = "${var.environment}-${var.vpc_name}-ROUTE53"
  }
}

#resource "aws_route53_record" "demo-record" {
#  count   = "${length(var.hostname)}"
#  name    = "${element(var.hostname,count.index )}"
#  records = ["${element(var.arecord,count.index )}"]
#  zone_id = "${aws_route53_zone.my-test-zone.id}"
#  type    = "A"
#  ttl     = "300"
#}