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
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main-vpc.id

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
}

### route associations public
resource "aws_route_table_association" "main-public-route-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-route-association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-private-route-association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-route-association-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_vpc_endpoint" "dkr" {
  vpc_id              = aws_vpc.main-vpc.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids = [
    aws_security_group.allow_http_anywhere.id,
  ]
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Name        = "dkr-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.main-vpc.id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type   = "Interface"
  security_group_ids = [
    aws_security_group.allow_http_anywhere.id,
  ]
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Name        = "logs-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main-vpc.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.main-private.id]

  tags = {
    Name        = "s3-endpoint"
    Environment = var.environment
  }
}