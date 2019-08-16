###### project/main.tf

provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.env_name}"
}

terraform {
  backend "s3" {
  }
}
