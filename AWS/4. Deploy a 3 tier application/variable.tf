# Default region for the AWS provider
variable "aws_region_default" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# Variable for the AWS Availablity Zone1
variable "aws_region1" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1a"
}

# variable for the AWS Availablity Zone2
variable "aws_region2" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-1b"
    }

# Name of the VPC
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "company-vpc"
  }

# Cidr block for the VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.200.0.0/16" 
  } 

# Cidr block for the public subnet 1
variable "public_subnet_cidr1" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.200.40.0/24"
  } 

  # Cidr block for public subnet 2
variable "public_subnet_cidr2" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.200.45.0/24"
  }

  # Cidr block for the private subnet1 for application  and servers
variable "private_subnet_cidr_app" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.200.50.0/24"
  }

  # Cidr block for the private subnet2 for application and servers
variable "private_subnet_cidr_app2" {
  description = "The CIDR block for the private subnet2"
  type        = string
  default     = "10.200.55.0/24"
  }

# cidr block for the private subnet for database servers
variable "private_subnet_db_cidr1" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.200.60.0/24"
  }

  # Cidr block for the private subnet2 for database servers
variable "private_subnet_db_cidr2" {
  description = "The CIDR block for the private subnet2"
  type        = string
  default     = "10.200.65.0/24"
  }


## Application Server Variables ##

# Variable for the application server AMI
variable "app_server_ami" {
  description = "The AMI ID for the application server"
  type        = string
  default     = "ami-08f44e8eca9095668" # Amazon Linux 2 AMI
}

# instance type for the application server
variable "app_server_instance_type" {
  description = "The instance type for the application server"
  type        = string
  default     = "t2.micro"
}

# SSH key pair name for the EC2 instances
variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "portfolio-key"
}


# Database Variables ##
## Database instance type
variable "db_instance_type" {
  description = "The instance type for the RDS database"
  type        = string
  default     = "db.t2.micro"
}

# Database allocated storage
variable "db_allocated_storage" {
  description = "The allocated storage for the RDS database in GB"
  type        = number
  default     = 20
}

# Database storage type
variable "db_storage_type" {
  description = "The storage type for the RDS database"
  type        = string
  default     = "gp2"
} 

# Database username
variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  default     = "admin"
}

# Database password
variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  default     = "Admin123!"
}

# Database parameter group name
variable "db_parameter_group_name" {
  description = "The parameter group name for the RDS database"
  type        = string
  default     = "default.mysql8.0"
}

