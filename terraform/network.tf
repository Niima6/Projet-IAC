resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-exploraria"
  }
}

resource "aws_subnet" "subnet-us-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "PublicSubnet-us-1"
  }
}

resource "aws_subnet" "subnet-us-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2b"

  tags = {
    Name = "PublicSubnet-us-2"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "InternetGateway-us"
  }
}

resource "aws_route_table" "public-us" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "PublicRouteTable-us"
  }
}

resource "aws_route_table_association" "public-us-1" {
  subnet_id      = aws_subnet.subnet-us-1.id
  route_table_id = aws_route_table.public-us.id
}

resource "aws_route_table_association" "public-us-2" {
  subnet_id      = aws_subnet.subnet-us-2.id
  route_table_id = aws_route_table.public-us.id
}