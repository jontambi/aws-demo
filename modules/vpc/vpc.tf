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
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-${var.vpc_name}-internetgateway"
  }
}

resource "aws_subnet" "private-subnet" {
  count = length(var.private_subnets_cidr)

  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.private_subnets_cidr, count.index)
  vpc_id            = aws_vpc.vpc.id

  tags = map(
    "Name", "${var.environment}-${var.vpc_name}-private-subnet-${count.index + 1}",
  )
}

resource "aws_subnet" "public-subnet" {
  count = length(var.public_subnets_cidr)
  map_public_ip_on_launch = true

  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.public_subnets_cidr, count.index)
  vpc_id            = aws_vpc.vpc.id

  tags = map(
    "Name", "${var.environment}-${var.vpc_name}-public-subnet-${count.index + 1}",
  )

}

resource "aws_default_route_table" "route-private" {
  #count = length(var.private_subnets_cidr)
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    nat_gateway_id = aws_nat_gateway.default.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.environment}-${var.vpc_name}-privateRouteTable" 
  }
}

resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.environment}-${var.vpc_name}-publicRouteTable"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)

  route_table_id = aws_default_route_table.route-private.id
  subnet_id      = element(aws_subnet.private-subnet.*.id, count.index)
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)

  route_table_id = aws_route_table.route-public.id
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)  
}

resource "aws_eip" "nat" {
  vpc   = true
  
  tags = {
    Name = "${var.environment}-${var.vpc_name}-ElasticIP"
  }
}

resource "aws_nat_gateway" "default" {
  depends_on = [ 
    aws_internet_gateway.igw
  ]

  #count         = length(var.public_subnets_cidr)
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet.0.id

  tags = {
    Name = "${var.environment}-${var.vpc_name}-NAT"
  }
  
}


