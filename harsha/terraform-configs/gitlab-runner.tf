# Deploy GitLAB Runner Compute Resources

variable "gitlab-runner_instance_count" {}

variable "gitlab-runner_instance_name" {
  type = "list"
}

variable "gitlab-runner_distribution" {}

variable "gitlab-runner_owner" {}

variable "gitlab-runner_filter_name" {}

variable "gitlab-runner_filter_value" {}

variable "gitlab-runner_server_instance_type" {}

variable "gitlab_runner_version" {
  default = ""
}

variable "gitlab_server_url" {
  default = ""
}

variable "project_registration_token" {
  default = ""
}

data "template_file" "gitlab-runner" {
  template = "${file("${path.module}/user-data/gitlab-runner.sh")}"
  vars = {
    GITLAB_RUNNER_VERSION = "${var.gitlab_runner_version}"
    GITLAB_SERVER_URL = "${var.gitlab_server_url}"
    PROJECT_REGISTRATION_TOKEN = "${var.project_registration_token}"
  }
}

module "gitlab-runnercompute" {
  source          = "../../modules/compute"
  instance_count  = "${var.project_registration_token != "" ? var.gitlab-runner_instance_count : 0 }"
  key_name        = "${var.key_name}"
  instance_type   = "${var.gitlab-runner_server_instance_type}"
  subnets         = "${module.networking.private_subnets}"
  user_data	  = "${data.template_file.gitlab-runner.rendered}"

  instance_security_group = ["${module.gitlab_sg.this_security_group_id}"]
  create_eip = false

  instance_name = "${var.gitlab-runner_instance_name}"
  instance_tags = "${map(
     "Distribution", "${var.gitlab-runner_distribution}"
  )}"

  owner        = "${var.gitlab-runner_owner}"
  filter_name  = "${var.gitlab-runner_filter_name}"
  filter_value = "${var.gitlab-runner_filter_value}"
  depends_id = "${module.gitlab-servercompute.depends_id}"
}
