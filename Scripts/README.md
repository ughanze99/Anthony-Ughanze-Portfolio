# Deployment files 

This folder will host all files needed for the deployment of any application. 
The EC2 instance can easily pull the files from git hub using the git command. This allows for scripts, docker files and html files to be available to the instance.

In a real life situation this would be replaced with a company repositoy. 

# Prerequisite 

*** Docker hub account *** 
* Create a Docker hub account that will be used to create a registry that will hold all docker images 
* Create a token account for authentication  and store the credentials in AWS Secrets manager
