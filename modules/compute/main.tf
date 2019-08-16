#-----compute/main.tf

data "aws_ami" "server_ami" {
  most_recent = true
  owners = [
    "${var.owner}"
  ]
  filter {
    name   = "${var.filter_name}"
    values = [
     "${var.filter_value}"
  ]
  }
}

resource "aws_eip" "tf_instance_eip" {
  count = "${var.create_eip}"
  instance = "${aws_instance.tf_server.id}"
}

resource "aws_instance" "tf_server" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.server_ami.id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.instance_security_group}"]
  subnet_id              = "${element(var.subnets, count.index)}"
  iam_instance_profile   = "${var.instance_profile}"
  source_dest_check = "${var.source_dest_check}"
  user_data = "${var.user_data}"

  tags = "${merge(
    var.instance_tags,
      map(
          "Name","${element(var.instance_name, count.index)}"
      ) 
  )}"
  volume_tags = "${merge(
    var.instance_tags,
      map(
          "Name","${element(var.instance_name, count.index)}"
      ) 
  )}"
  root_block_device {
    volume_size = "${var.root_volume_size}"
    volume_type = "${var.root_volume_type}"
    encrypted = "${var.root_encrypted}"
  }
  lifecycle {
    ignore_changes = ["ami", "private_ip", "root_block_device"]
  }
}

resource "null_resource" "dummy_dependency" {
  depends_on = ["aws_instance.tf_server"]
}
