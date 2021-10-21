resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_vpc}"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = {
    "Name" = "${var.tag}-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.public_subnet_cidr,count.index)
  availability_zone = element(var.availability_zone,count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${aws_vpc.vpc.tags.Name}-publicsubnet-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.private_subnet_cidr)
  cidr_block = element(var.private_subnet_cidr,count.index)
  availability_zone = element(var.availability_zone,count.index)
  map_public_ip_on_launch = false
  tags = {
    "Name" = "${var.tag}-privatesubnet-${count.index+1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${aws_vpc.vpc.tags.Name}-igw"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "${var.tag}-publicRouteTable"
  }
}

resource "aws_route_table_association" "rta" {
  count = length(var.public_subnet_cidr)
  subnet_id = element(var.public_subnet_cidr.*.id, count.index)
  route_table_id = aws_route_table.public-RT.id
}
