variable "vpc_name" {
  default     = "grupogloria"
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC cidr block"
}

variable "subnets_cidr" {
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "A list of VPC subnet IDs which the worker nodes are using."
}

variable "azs" {
  default     = ["us-east-1a", "us-east-1b"]
  description = "Available zones"
}

variable "prefix" {
  description = "This is the environment where your cluster is deployed. qa, prod, or dev"
}