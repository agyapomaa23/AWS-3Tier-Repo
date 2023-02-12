# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "dev vpc"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id    =  aws_vpc.vpc.id

  tags      = {
    Name    = "dev internet gateway"
  }
}

# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet az1"
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet az2"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id       =  aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags       = {
    Name     = "public route table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public_subnet_1.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.public_subnet_2.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_az1_cidr
  availability_zone        = "eu-west-2a"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private subnet az1"
  }
}

# Create Private Subnet 2
# terraform aws create subnet
resource "aws_subnet" "private-subnet-2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_az2_cidr
  availability_zone        = "eu-west-2b"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private subnet az2"
  }
}

# Create  Private Route
resource "aws_route_table" "private-route-table" {
  vpc_id       =  aws_vpc.vpc.id

  tags       = {
    Name     = "private route table"
  }
}

# Associate Private Subnet 1 to "Private Route Table"
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.private-subnet-1.id
  route_table_id      = aws_route_table.private-route-table.id
}

# Associate Private Subnet 2 to "Private Route Table"
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.private-subnet-2.id
  route_table_id      = aws_route_table.private-route-table.id
}