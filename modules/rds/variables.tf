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

variable "azs" {
  description = "Available zones"
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "demosre"
}

#variable "multi_az" {
#  description = "Specifies if the RDS instance is multi-AZ"
#  type        = bool
#  default     = true
#}

variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
  default     = "demosre-postgres"
}