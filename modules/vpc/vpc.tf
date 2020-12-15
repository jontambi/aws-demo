#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#
resource "aws_vpc" "vpc" {
  #name                 = "${var.environment}-${var.vpc_name}"
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = map(
    "Name", "${var.environment}-${var.vpc_name}-vpc",
    "kubernetes.io/cluster/${var.environment}-${var.vpc_name}", "shared",
  )
}

resource "aws_subnet" "subnet" {
  count = length(var.subnets_cidr)
  #map_public_ip_on_launch = true

  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.subnets_cidr, count.index)
  vpc_id            = aws_vpc.vpc.id

  tags = map(
    "Name", "${var.environment}-${var.vpc_name}-subnet-${count.index + 1}",
    "kubernetes.io/cluster/${var.environment}-${var.vpc_name}", "shared",
  )

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-${var.vpc_name}-internetgateway"
  }
}

resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.environment}-${var.vpc_name}-publicRouteTable"
  }
}

resource "aws_route_table_association" "route-a" {
  count = length(var.subnets_cidr)

  route_table_id = aws_route_table.route.id
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
}