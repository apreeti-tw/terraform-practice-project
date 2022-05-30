resource "aws_eip" "nat-eip" {
  vpc = "true"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.main-public-subnet-1.id
  depends_on = [aws_internet_gateway.main-igw]
  tags = {
    Name = "nat-gw"
  }
}

resource "aws_route_table_association" "nat-gw-private-subnet-1" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.main-private-subnet-1.id
}

resource "aws_route_table_association" "nat-gw-private-subnet-2" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.main-private-subnet-2.id
}
