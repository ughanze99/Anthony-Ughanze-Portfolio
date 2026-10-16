## Deployment of a three tier application 

This project works through the process of deploying a three tier application 
this would consist of a front end which woud be facing the public network but also be in the form of an ALB, a back end which would be the application hosted on an EC2 instance and a data base to support the customer data.  

    The deployent will be done using terraform to manage the deployment and also use and AWS S3 bucket for the backend. The application will be deployed across multiple availablity zones to create a highly available architecture 

# Instructions 

# Variable file 

* define both avaialability zones for the deployment 
* Define all Cidr blocks for the subnets associated with the ALB, application and subnet for each each AZ
* 

# VPC 
* Create a VPC in one region and create six subnets across two availablity zones 
* Two public subnets for the ALB one in each AZ 
* two private subnets for the 2 EC2's hosting the application 
* two private subnets for the Data base 
* Create internet gateway and associate with both public subnets 
* Create NAT and associate with both public subnets 
* Create 2 routing tables for both application private subnets and point internet traffic to the NAT in the public subnet of the corresponding AZ. 
* Create 2 routing tables for both data base private subnets and point internet traffice to the NAT in the public subnet of the corresponding AZ
* 

# Servers 
* Provision for 2 servers, copy the index file to the servers and move them to the location for the webservers
* enable web service on the servers 
* generate a ssh private key and use the key to create a key pair for the Ec2 instances 
* Create a securit group and grant access to the ALB 

# ALB 
* Create the aplication load balancer 
* Create a security group for the ALB and allow HTTP traffic
* Create a target group 
* Create a listener 
* Add both serves to the listener 

# db 
* provisioned for a Data base 
* Created a security group for the DB and allowed access from the application security group 
* 