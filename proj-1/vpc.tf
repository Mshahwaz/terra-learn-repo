resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "my-private-subnet"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "my-public-route" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.my-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "my-sg"
  }
}