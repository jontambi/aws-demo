variable "vpc_id" {}

variable "subnet1" {}

variable "subnet2" {}

variable "environment" {
  description = "This is the environment where your cluster is deployed. qa, prod, or dev"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}
