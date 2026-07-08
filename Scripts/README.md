# Deployment files 

This folder will host all files needed for the deployment of any application. 
The EC2 instance can easily pull the files from git hub using the git command. This allows for scripts, docker files and html files to be available to the instance.

In a real life situation this would be replaced with a company repositoy. 

# Prerequisite 

*** Docker hub account *** 
* Create a Docker hub account that will be used to create a registry that will hold all docker images 
* Create a token account for authentication  and store the credentials in AWS.Secrets manager

# IAM role 
Create an IAM role that has permission to pull the secret from secret manager
Assign the role to the EC2 instance. 

# Server deployment 
Provision for the EC2 instance and allow traffic on port 80 on the Security group

# Build depoyment script 
* Run updates
* Install Docker 
* Install AWS CLI
* Pull the docker and html file from github
* Change to the correct directory 
* buidl the image 
* get the password from AWS secret manager 
* login to docker hub 
* run the docker image