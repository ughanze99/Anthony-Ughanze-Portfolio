## Cloud provider configuration for AWS 
# Default AWS region to use for resources 
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# Default path for the state file in the S3 bucket
variable "s3_state_file_path" {
  description = "The path for the Terraform state file in the S3 bucket"
  type        = string
  default     = "portfolio/5.Deploy Docker image on Ec2/terraform.tfstate"
}

## Network configuration variables
# Default CIDR block for the VPC
variable "cidr_block_Company" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.200.0.0/16"
}

# Default CIDR block for the subnet
variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.200.50.0/24"
}

# Availability zone for the subnet
variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
} 

## EC2 instance configuration variables
# Default instance type for the EC2 instance
variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

# Default AMI ID for the EC2 instance
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0bc7f2dbdcc6b5303" # Ubuntu Server 26.04
}

# URL for files to be downloaded and used in the EC2 instance
variable "dockerfile_url" {
  description = "The URL for the Dockerfile to be downloaded and used in the EC2 instance"
  type        = string
  default     = "https://raw.githubusercontent.com/ughanze99/Anthony-Ughanze-Portfolio/refs/heads/main/Scripts/Docker%20files/Dockerfile"
}

variable "target_directory" {
  description = "The target directory where the files will be downloaded and used in the EC2 instance"
  type        = string
  default     = "/opt/anthony-ughanze-portfolio"
}

## This is added directly to the deployment file, this is kept here for reference, but not used in the Terraform configuration.
/*
variable "html_file_url" {
  description = "The URL for the HTML file to be downloaded and used in the EC2 instance"
  type        = string
  default     = "https://raw.githubusercontent.com/ughanze99/Anthony-Ughanze-Portfolio/refs/heads/main/Scripts/Html%20files/index.html"
}

variable "deploy_script_url" {
  description = "The URL for the deployment script to be downloaded and used in the EC2 instance"
  type        = string
  default     = "https://raw.githubusercontent.com/ughanze99/Anthony-Ughanze-Portfolio/refs/heads/main/Scripts/Deployment/Deployment.sh"
}
*/
