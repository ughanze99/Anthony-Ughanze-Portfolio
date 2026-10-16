terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"

  # Use the S3 bucket as the backend for storing the Terraform state file
  backend "s3" {
    bucket         = "anthony-ughanze-portfolio-backend"
    key            = "portfolio/4.Deploy a 3 tier application/terraform.tfstate"
    region         = "us-east-1"
  }
}