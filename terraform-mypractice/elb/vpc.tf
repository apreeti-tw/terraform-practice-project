resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_classiclink = false
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "main-public-subnet-1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.main-vpc.id
  map_public_ip_on_launch = true
  availability_zone = var.AWS_SUB_REGION_1a
  tags = {
    Name = "main-public-subnet-1"
  }
}

resource "aws_subnet" "main-public-subnet-2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.main-vpc.id
  map_public_ip_on_launch = true
  availability_zone = var.AWS_SUB_REGION_1b
  tags = {
    Name = "main-public-subnet-2"
  }
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "main-rt" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "main-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
}

resource "aws_route_table_association" "main-rt-public-subnet-1" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.main-public-subnet-1.id
}

resource "aws_route_table_association" "main-rt-public-subnet-2" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.main-public-subnet-2.id
}
