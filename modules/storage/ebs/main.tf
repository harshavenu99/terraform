 resource "aws_ebs_volume" "this" {
  encrypted = "${var.ebs_encrypted}"
  count = "${var.ebs_count}"
  availability_zone = "${var.availability_zone[count.index]}"
  size              = "${var.volume_size}"
  type  = "${var.volume_type}"
  iops	= "${var.iops}"
  tags = "${merge(
    var.instance_tags,
      map(
          "Name","${element(var.instance_name, count.index)}"
      ) 
  )}"
 }

 resource "aws_volume_attachment" "this_ec2" {
  count = "${var.ebs_count}"
  device_name = "${var.device_name}"
  volume_id   = "${aws_ebs_volume.this.*.id[count.index]}"
  instance_id = "${var.server_id[count.index]}"
}
