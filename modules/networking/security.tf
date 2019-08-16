#---- networking/security.tf

resource "aws_network_acl" "tf_all" {
   vpc_id = "${aws_vpc.tf_vpc.id}"

    egress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        name = "ks-${var.aws_region}-nacl"
    }
}
