#######
# VPC #
#######
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-exploraria"
  }
}

###########
# Subnets #
###########
resource "aws_subnet" "subnet-us-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.aws_regions[0]

  tags = {
    Name = "PublicSubnet-us-1"
  }
}
resource "aws_subnet" "subnet-us-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.aws_regions[1]

  tags = {
    Name = "PublicSubnet-us-2"
  }
}

resource "aws_subnet" "private-subnet-us-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.aws_regions[0]

  tags = {
    Name = "PrivateSubnet-us-1"
  }
}
resource "aws_subnet" "private-subnet-us-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.aws_regions[1]

  tags = {
    Name = "PrivateSubnet-us-2"
  }
}

###################
# DB Subnet Group #
###################

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private-subnet-us-1.id, aws_subnet.private-subnet-us-2.id]  # Replace with actual subnet IDs

  tags = {
    Name = "rds-subnet-group"
  }
}

####################
# Internet Gateway #
####################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "InternetGateway-us"
  }
}

###############
# Route Table #
###############
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

################
# Associations #
################
resource "aws_route_table_association" "public-us-1" {
  subnet_id      = aws_subnet.subnet-us-1.id
  route_table_id = aws_route_table.public-us.id
}

resource "aws_route_table_association" "public-us-2" {
  subnet_id      = aws_subnet.subnet-us-2.id
  route_table_id = aws_route_table.public-us.id
}
