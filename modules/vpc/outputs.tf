output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = aws_subnet.private-subnet[*].id
}

output "route_table_ids" {
  value = aws_route_table.route.id
}