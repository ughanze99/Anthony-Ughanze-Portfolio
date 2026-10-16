## Network configuration for the EC2 instance
# Creates a VPC with a CIDR block of 10.200.0.0/16."
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_Company
  
  tags = {
    Name = "Company_VPC"
  }
}

# Creates an Internet Gateway for the VPC to allow internet access.
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Company_Internet_Gateway"
  }
}

# Creates a route table for the VPC to define how traffic is routed.
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Associates the route table with the Houston subnet to enable internet access for instances in that subnet.
resource "aws_route_table_association" "houston" {
  subnet_id      = aws_subnet.houston.id
  route_table_id = aws_route_table.main.id
}

# Creates a subnet within the VPC for the Houston Branch 
resource "aws_subnet" "houston" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "Houston_Subnet"
  }
}