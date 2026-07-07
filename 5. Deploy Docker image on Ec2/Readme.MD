## Deploy a docker image on an EC2 instance 
This project guides towards the building of an EC2 instance and running an application as a docker image. 

# Instructions 

# Deploy an EC2 instance that will run Docker 
 
 Please refreence "1. Deploy EC2 instance" for instructions.

# IAM permissions 

* Create a role to be assigned to the EC2 instance. 
* Assign permission to the role to query secret manager for the password

# Deploying the docker image on the EC2 instance

 * Create a docker file that will build the image.
 * Create a bash script file to perform the following task.
    * Install docker on the EC2 instance. 
    * Start the docker service on the instance. 
    * Build the docker image.
    * Push a copy of the docker image to a repository in Docker hub. 
    * run the docker image on the instance.
