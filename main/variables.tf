variable "vpc_name" {
  default     = "sre"
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  default     = "10.100.0.0/16"
  description = "VPC cidr block"
}

variable "subnets_cidr" {
  default     = ["10.100.1.0/24", "10.100.2.0/24"]
  description = "A list of VPC subnet IDs which the worker nodes are using."
}

variable "azs" {
  default     = ["us-east-1a", "us-east-1b"]
  description = "Available zones"
}

variable "prefix" {
  description = "This is the environment where your cluster is deployed. qa, prod, dev or demo"
}