resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main_public" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.main_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_gateway.id
}

resource "aws_route_table" "main_public_route_table" {
  vpc_id = aws_vpc.example_vpc.id
}

resource "aws_route_table_association" "main_subnet_route_association" {
  subnet_id      = aws_subnet.main_public.id
  route_table_id = aws_route_table.main_public_route_table.id
}
