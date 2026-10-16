terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
      region  = "var.aws_region"
    }
  }

  required_version = ">= 1.2"

  # Use the S3 bucket as the backend for storing the Terraform state file
  backend "s3" {
    bucket         = "anthony-ughanze-portfolio-backend"
    key            = "portfolio/5.Deploy Docker image on Ec2/terraform.tfstate"
    region         = "us-east-1"
  }


}