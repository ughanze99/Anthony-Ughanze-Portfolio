# This is a Terraform configuration file that deploys an EC2 instance in AWS. 

# Identifies the AWS provider and sets the region to "us-east-1".
provider "aws" {
  region = var.region
}

#Identifies the latest Ubuntu AMI available in the specified region.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

# Creates an EC2 instance using the latest Ubuntu AMI and specifies the instance type as "t2.micro".
#Deploy the sever in the Houston subnet created for the company.
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
    subnet_id     = aws_subnet.houston.id

    tags = {
      Name = "App_Server"
    }

}

# Creates a VPC with a CIDR block of 10.200.0.0/16."
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_Company
  
  tags = {
    Name = "Company_VPC"
  }
}

# Creates a subnet within the VPC for the Houston Branch 
resource "aws_subnet" "houston" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "Houston_Subnet"
  }
}