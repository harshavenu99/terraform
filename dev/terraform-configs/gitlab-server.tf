# Deploy GitLAB Runner Compute Resources

variable "gitlab-server_instance_count" {}

variable "gitlab-server_instance_name" {
  type = "list"
}

variable "gitlab-server_distribution" {}

variable "gitlab-server_owner" {}

variable "gitlab-server_filter_name" {}

variable "gitlab-server_filter_value" {}

variable "gitlab-server_server_instance_type" {}

variable "gitlab_server_external_url" {
  default = ""
}

data "template_file" "gitlab-server" {
  template = "${file("${path.module}/user-data/gitlab-server.sh")}"
  vars = {
    GITLAB_SERVER_EXTERNAL_URL = "${var.gitlab_server_external_url}"
  }
}

module "gitlab-servercompute" {
  source          = "../../modules/compute"
  instance_count  = "${var.gitlab_server_external_url != "" ? var.gitlab-runner_instance_count : 0 }"
  key_name        = "${var.key_name}"
  instance_type   = "${var.gitlab-server_server_instance_type}"
  subnets         = "${module.networking.private_subnets}"
  user_data	  = "${data.template_file.gitlab-server.rendered}"

  instance_security_group = ["${module.gitlab_sg.this_security_group_id}"]
  create_eip = false

  instance_name = "${var.gitlab-server_instance_name}"
  instance_tags = "${map(
     "Distribution", "${var.gitlab-server_distribution}"
  )}"

  owner        = "${var.gitlab-server_owner}"
  filter_name  = "${var.gitlab-server_filter_name}"
  filter_value = "${var.gitlab-server_filter_value}"
  depends_id = ""
}
