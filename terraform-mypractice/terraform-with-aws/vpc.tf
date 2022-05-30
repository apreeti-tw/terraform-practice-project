resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_classiclink = "false"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main-public-subnet-1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "main-public-subnet-1"
  }
}

resource "aws_subnet" "main-public-subnet-2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "main-public-subnet-2"
  }
}

resource "aws_subnet" "main-private-subnet-1" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-south-1a"
  tags = {
    Name = "main-private-subnet-1"
  }
}

resource "aws_subnet" "main-private-subnet-2" {
  cidr_block = "10.0.4.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-south-1b"
  tags = {
    Name = "main-private-subnet-2"
  }
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "main-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = {
    Name = "main-rt"
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