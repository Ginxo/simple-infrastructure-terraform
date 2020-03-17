### Internet VPC
resource "aws_vpc" "main-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
}

### Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}a"
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}b"
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}a"
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}b"
}

### Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main-vpc.id
}

### route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
}

### route associations public
resource "aws_route_table_association" "main-public-route-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.main-public.id
}