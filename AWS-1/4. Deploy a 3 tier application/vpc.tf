# This file defines the VPC for the 3-tier application deployment. 
# It consit of 2 public subnets for the application load balancer, 2 private subnets for the application servers, and 2 private subnets for the database servers.
# All withing 2 availability zones for high availability and fault tolerance.


# Base VPC that will be used for the 3-tier application deployment
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"

  tags = {
    Name = var.vpc_name
  }
}

# Create a public subnet for the application load balancer
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr1
  availability_zone = var.aws_region1

  tags = {
    Name = "${var.vpc_name}-public-subnet1"
  }
}

# Create a public subnet for the application load balancer
resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr2
  availability_zone = var.aws_region2

  tags = {
    Name = "${var.vpc_name}-public-subnet2"
  }
}

# Create a private subnet1 for the application servers
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_app
  availability_zone = var.aws_region1

  tags = {
    Name = "${var.vpc_name}-private-subnet-app1"
  }
}

# Create a private subnet2 for the application servers
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_app2
  availability_zone = var.aws_region2

  tags = {
    Name = "${var.vpc_name}-private-subnet-app2"
  }
}

# Create a private subnet for the database servers
resource "aws_subnet" "private_db1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_db_cidr1
  availability_zone = var.aws_region1

  tags = {
    Name = "${var.vpc_name}-private-subnet-db1"
  }
}

# Create a private subnet for the database servers
resource "aws_subnet" "private_db2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_db_cidr2
  availability_zone = var.aws_region2

  tags = {
    Name = "${var.vpc_name}-private-subnet-db2"
  }
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create a NAT Gateway for the private subnet in availability zone 1
resource "aws_nat_gateway" "main1" {
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "${var.vpc_name}-nat-gateway1"
  }
}

# Create a NAT Gateway for the private subnet in availability zone 2
resource "aws_nat_gateway" "main2" {
  allocation_id = aws_eip.nat[1].id
  subnet_id     = aws_subnet.public2.id

  tags = {
    Name = "${var.vpc_name}-nat-gateway2"
  }
}

# Create Elastic IPs for the NAT Gateways
resource "aws_eip" "nat" {
  count = 2

  tags = {
    Name = "${var.vpc_name}-nat-eip-${count.index }"
  }
}

#

# Create a route table for the public1 subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Associate the public subnets1 with the route table
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

# Associate the public subnets2 with the route table
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# Create route tables for the private subnets
resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_nat_gateway.main1.id
  }
}

resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_nat_gateway.main2.id
  }
}

# Associate the private subnets with the route tables
resource "aws_route_table_association" "private_app1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_app.id
}

resource "aws_route_table_association" "private_app2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_app.id
}

resource "aws_route_table_association" "private_db1" {
  subnet_id      = aws_subnet.private_db1.id
  route_table_id = aws_route_table.private_db.id
}

resource "aws_route_table_association" "private_db2" {
  subnet_id      = aws_subnet.private_db2.id
  route_table_id = aws_route_table.private_db.id
}

