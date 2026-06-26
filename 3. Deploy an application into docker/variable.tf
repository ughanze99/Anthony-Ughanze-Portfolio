variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
  default     = "us-east-1"
}

# Name of the repository holding the Docker image
variable "my_ecr_repo_name" { 
  description = "The name of the repository holding the Docker image"
  type        = string
  default     = "my-app-repo"
}

