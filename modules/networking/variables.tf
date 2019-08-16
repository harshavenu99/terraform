#------networking/variables.tf

variable "aws_region" {}

variable "public_cidrs" {
  type = "list"
}

variable "private_cidrs" {
  type = "list"
}

variable "accessip" {}

variable "vpc_cidr" {}

variable "env_name" {}

variable "network_interface" {}
