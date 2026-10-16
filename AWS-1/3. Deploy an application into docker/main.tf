#This is a Terraform configuration file that deploys a static website to AWS S3.

# Identifies the AWS provider and sets the region to "us-east-1".
provider "aws" {
  region = var.region
}

# Creates a repository in AWS ECR (Elastic Container Registry) to store Docker images.
resource "aws_ecr_repository" "my_ecr_repo" {
  name = var.my_ecr_repo_name
}

