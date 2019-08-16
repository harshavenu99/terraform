variable "availability_zone" {
	type = "list"
}

variable "ebs_count" {}

variable "server_id" {
	type= "list"
}


variable "volume_size" {}

variable "device_name" {}

variable "volume_type" {
	default = "gp2"
}	

variable "iops" {
	default = ""
}

variable "instance_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = "map"
  default     = {}
}

variable "instance_name" {
  type = "list"
}

variable "ebs_encrypted" {
  default = false
  type = "string"
}
