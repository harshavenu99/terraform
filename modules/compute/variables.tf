#-----compute/variables.tf

variable "key_name" {}

variable "instance_count" {}

variable "instance_type" {}

variable "instance_security_group" {
  description = "A list of security group IDs to assign to the ELB"
  type        = "list"
}

variable "owner" {}

variable "filter_name" {
  default = ""
}

variable "filter_value" {
  default = ""
}

variable "instance_name" {
  type = "list"
}

variable "subnets" {
  type = "list"
}

variable "create_eip" {
  description = "If set to true, create an EIP"
}

variable "instance_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = "map"
  default     = {}
}

variable "root_volume_size" {
  default = 50	
}

variable "instance_profile" {
  default = ""
}
     
variable "root_volume_type" {
  default = "gp2"
}

variable "source_dest_check" {
  default = true
}

variable "root_encrypted" {
  default = false
  type = "string"
}

variable "user_data" {
  default = ""
}

variable "depends_id" {}
