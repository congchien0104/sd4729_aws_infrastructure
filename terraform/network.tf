# Create a VPC
resource "aws_vpc" "development-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-VPC"
  }
}

# Create public Subnet
resource "aws_subnet" "public-subnet-1" {
  cidr_block = "${var.public_subnet_1_cidr}"
  vpc_id = "${aws_vpc.development-vpc.id}"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.environment}-Public-Subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block = "${var.public_subnet_2_cidr}"
  vpc_id = "${aws_vpc.development-vpc.id}"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.environment}-Public-Subnet-2"
  }
}

# Create RouteTable
resource "aws_route_table" "public-route-table" {
    vpc_id = "${aws_vpc.development-vpc.id}"
    tags = {
        Name = "${var.environment}-Public-RouteTable"
    }
}

# Associate Subnet with RouteTable
resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = "${aws_route_table.public-route-table.id}"
  subnet_id = "${aws_subnet.public-subnet-1.id}"
}

resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = "${aws_route_table.public-route-table.id}"
  subnet_id = "${aws_subnet.public-subnet-2.id}"
}

# Create Internet Gateway
resource "aws_internet_gateway" "development-igw" {
  vpc_id = "${aws_vpc.development-vpc.id}"
  tags = {
    Name = "${var.environment}-IGW"
  }
}

# Create EC2 Instance
resource "aws_route" "public-internet-igw-route" {
  route_table_id         = "${aws_route_table.public-route-table.id}"
  gateway_id             = "${aws_internet_gateway.development-igw.id}"
  destination_cidr_block = "0.0.0.0/0"
}

