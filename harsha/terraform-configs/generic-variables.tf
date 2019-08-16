
#------- GENERIC VARIABLES

variable "aws_region" {}

variable "env_name" {}

variable "key_name" {}

variable "instance_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = "map"
  default     = {}
}

