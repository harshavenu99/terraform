#-----networking/outputs.tf

output "public_subnets" {
  value = "${aws_subnet.tf_public_subnet.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.tf_private_subnet.*.id}"
}

output "vpc_id" {
  value = "${aws_vpc.tf_vpc.id}"
}
