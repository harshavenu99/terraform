# ELB Security group


variable "gitlab_security_group_name" {}
  
variable "bastion_security_group_name" {}
  
# GitLAB Security group
module "gitlab_sg" {
  source      = "../../modules/sg"
  name        = "${var.gitlab_security_group_name}"
  description = "Security group for GitLAB"
  vpc_id      = "${module.networking.vpc_id}"

  ingress_with_self = [
    {
      rule = "all-all"
    }
  ]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = "${module.bastion_sg.this_security_group_id}"
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1

  egress_with_cidr_blocks = [
    {
      rule = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# Bastion Security Group
module "bastion_sg" {
  source      = "../../modules/sg"
  name        = "${var.bastion_security_group_name}"
  description = "Security group for bastion"
  vpc_id      = "${module.networking.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "${var.my_ip}"
    }
  ]
  egress_with_cidr_blocks = [
    {
      rule = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
