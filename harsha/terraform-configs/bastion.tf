# Deploy Bastion Compute Resource

variable "bastion_instance_count" {}

variable "bastion_instance_name" {
  type = "list"
}

variable "bastion_owner" {}

variable "bastion_filter_name" {}

variable "bastion_filter_value" {}

variable "bastion_instance_type" {}

variable "bastion_distribution" {}

module "bastioncompute" {
  source          = "../../modules/compute"
  instance_count  = "${var.bastion_instance_count}"
  key_name        = "${var.key_name}"
  instance_type   = "${var.bastion_instance_type}"
  subnets         = "${module.networking.public_subnets}"
  source_dest_check = false

  instance_security_group = ["${module.bastion_sg.this_security_group_id}"]
  create_eip = true

  instance_name = "${var.bastion_instance_name}"
  instance_tags = "${map(
     "Distribution", "${var.bastion_distribution}"
  )}"

  owner        = "${var.bastion_owner}"
  filter_name  = "${var.bastion_filter_name}"
  filter_value = "${var.bastion_filter_value}"
  depends_id = ""
}
