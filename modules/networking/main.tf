#----networking/main.tf

data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "ks-${var.aws_region}-${var.env_name}-vpc"
  }
}

resource "aws_eip" "tf_eip" {
  vpc   = true
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags {
    Name = "ks-${var.aws_region}-${var.env_name}-igw"
  }
}

resource "aws_nat_gateway" "tf_nat_gw" {
  allocation_id = "${aws_eip.tf_eip.id}"
  subnet_id     = "${aws_subnet.tf_public_subnet.*.id[count.index]}"
  depends_on    = ["aws_internet_gateway.tf_internet_gateway"]

  tags {
    Name = "ks-${var.aws_region}-${var.env_name}-nat-gw"
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  route {
    cidr_block = "${var.accessip}"
    gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
  }

  tags {
    Name = "ks-${var.aws_region}-${var.env_name}-public-rt"
  }
}

resource "aws_route_table" "tf_private_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  route {
    cidr_block     = "${var.accessip}"
    nat_gateway_id = "${aws_nat_gateway.tf_nat_gw.*.id[count.index]}"
  }

  tags {
    Name = "ks-${var.aws_region}-${var.env_name}-private-rt"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  count             = "${length(var.public_cidrs)}"
  vpc_id            = "${aws_vpc.tf_vpc.id}"
  cidr_block        = "${var.public_cidrs[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "ks-${data.aws_availability_zones.available.names[count.index]}-${var.env_name}-public-subnet"
  }
}

resource "aws_subnet" "tf_private_subnet" {
  count             = "${length(var.private_cidrs)}"
  vpc_id            = "${aws_vpc.tf_vpc.id}"
  cidr_block        = "${var.private_cidrs[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "ks-${data.aws_availability_zones.available.names[count.index]}-${var.env_name}-private-subnet"
  }
}

resource "aws_route_table_association" "tf_public_assoc" {
  count          = "${aws_subnet.tf_public_subnet.count}"
  subnet_id      = "${aws_subnet.tf_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_public_rt.id}"
}

resource "aws_route_table_association" "tf_private_assoc" {
  count          = "${aws_subnet.tf_private_subnet.count}"
  subnet_id      = "${aws_subnet.tf_private_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_private_rt.id}"
}

resource "aws_main_route_table_association" "tf_main_assoc" {
  vpc_id         = "${aws_vpc.tf_vpc.id}"
  route_table_id = "${aws_route_table.tf_private_rt.id}"
}
