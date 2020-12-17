output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnet_id" {
  value = aws_subnet.private-subnet[*].id
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet[*].id
}

output "public_route_table_id" {
  value = aws_route_table.route-public[*].id
}

output "private_route_table_id" {
  value = aws_default_route_table.route-private[*].id
}


output "private_subnet1" {
  value = element(aws_subnet.private-subnet.*.id, 3 )
}

output "private_subnet2" {
  value = element(aws_subnet.private-subnet.*.id, 4 )
}