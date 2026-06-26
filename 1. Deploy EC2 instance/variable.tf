#This file will contain the variables used in the Terraform configuration for deploying an EC2 instance in AWS. 

# This terraform deployment is for a company and the policy is to deploy all resources in the "us-east-1" region. The variable "region" is defined with a default value of "us-east-1".
variable "region" {
  description = "All resources associated with the company are to be deployed in this region."
  default     = "us-east-1"
}

# This variable defines the CIDR block for the VPC that will be created for the company. The default value is set to "10.200.0.0/16".
variable "cidr_block_Company" {
  description = "CIDR block for the VPC."
  default     = "10.200.0.0/16"
}

#The company has a branch in Houston, and the CIDR block for the Houston subnet is defined as "10.200.50.0/24".
variable "subnet_cidr_block" {
  description = "CIDR block for the Houston subnet."
  default     = "10.200.50.0/24"
}
