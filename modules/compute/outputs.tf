#-----compute/outputs.tf


output "server_id" {
  value = "${aws_instance.tf_server.*.id}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.tf_server.*.public_ip)}"
}

output "availability_zone" {
  value       = "${aws_instance.tf_server.*.availability_zone}"
}

output "network_interface" {
  value       = ["${aws_instance.tf_server.*.primary_network_interface_id}"]
}

output "depends_id" { 
  value = "${null_resource.dummy_dependency.id}" 
}
