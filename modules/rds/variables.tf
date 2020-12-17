variable "rds_subnet1" {}
variable "rds_subnet2" {}
variable "db_instance" {}
variable "vpc_id" {}

variable "environment" {
  description = "This is the environment where your cluster is deployed. qa, prod, or dev"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}