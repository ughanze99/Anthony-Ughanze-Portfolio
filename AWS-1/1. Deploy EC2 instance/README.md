# Deploying an EC2 instance


The Terraform script creates and EC2 instance using the latest version of an Ubuntu AMI image. 
The EC2 instance should be deployed in the defined region, VPC and subnet. 

# Instructions 

* Create the Main.tf, terraform.tf and variable.tf files in the directory 

Terraform.tf 
   * Define the cloud provider and also the required version

variable.tf 
   * Create the region variable 
   * Create the CIDR block for the VPC 
   * Create the CIDR block for the subnet

main.tf 
   * Set the region so that all resources are deployed to the same region
   * Define the AMI image to be used. 
   * Define the VPC and the subnet.
   * Define the EC2 instance to be deployed.
   * Include the VPC and subnet in the EC2.
