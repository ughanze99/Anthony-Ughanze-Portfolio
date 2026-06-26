#This file will contain the variables used in the Terraform configuration for deploying an EC2 instance in AWS. 

# This terraform deployment is for a company and the policy is to deploy all resources in the "us-east-1" region. The variable "region" is defined with a default value of "us-east-1".
variable "region" {
  description = "All resources associated with the company are to be deployed in this region."
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to host the static website."
  default     = "anthonyughanzeportfolio"
}

# html file name to be uploaded to the S3 bucket for the static website. The default value is set to "index.html".
variable "html_file_name" {
  description = "The name of the HTML file to be uploaded to the S3 bucket for the static website."
  default     = "index.html"
  type        = string
}

#html file name for error page to be uploaded to the S3 bucket for the static website. The default value is set to "error.html".
variable "error_file_name" {
  description = "The name of the HTML file to be uploaded to the S3 bucket for the static website."
  default     = "error.html"
  type        = string
}