# Deploy Networking Resources

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = "list"
}

variable "instance_security_groups" {
  description = "A list of security group IDs to assign to the Instances"
  type        = "list"
  default     = []
}

variable "private_cidrs" {
  type = "list"
}

variable "accessip" {}

variable "my_ip" {}


module "networking" {
  source        = "../../modules/networking"
  vpc_cidr      = "${var.vpc_cidr}"
  public_cidrs  = "${var.public_cidrs}"
  private_cidrs = "${var.private_cidrs}"
  accessip      = "${var.accessip}"
  aws_region    = "${var.aws_region}"
  env_name	= "${var.env_name}"
}
