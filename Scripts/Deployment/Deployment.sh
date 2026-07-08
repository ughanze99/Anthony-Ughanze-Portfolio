#!/bin/bash

# This script is used to deploy a Docker image on an EC2 instance running Ubuntu.

# Exit immediately if a command exits with a non-zero status.
set -e

# Installing updates and Docker on the EC2 instance
echo "===== Installing updates =====" 
sudo apt-get update -y
sudo apt-get upgrade -y

echo "===== Installing Docker ====="
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install AWS CLI
echo "===== Installing AWS CLI ====="
sudo apt-get install -y awscli

echo "===== Verifying Docker installation ====="
docker --version

# Gets the Dockerfile and HTML file from the GitHub repository and saves them as variables. The target directory is set to /opt/anthony-ughanze-portfolio.
dockerfile="https://raw.githubusercontent.com/ughanze99/Anthony-Ughanze-Portfolio/refs/heads/main/Scripts/Docker%20files/Dockerfile"
htmlfile="https://raw.githubusercontent.com/ughanze99/Anthony-Ughanze-Portfolio/refs/heads/main/Scripts/Html%20files/index.html"
target_dir="/opt/anthony-ughanze-portfolio"

 # Check if target directory exists, if not create it
if [ ! -d "$target_dir" ]; then
   sudo mkdir -p "$target_dir"
fi

 # Download the Dockerfile and HTML file
echo " === Downloading Dockerfile === "
sudo curl -o "$target_dir/Dockerfile" "$dockerfile"

echo " === Downloading HTML file === "
sudo curl -o "$target_dir/index.html" "$htmlfile"


# Build the docker image from the Dockerfile
cd "$target_dir"
sudo docker build -t tony-ugh-pfl . 
sudo docker tag tony-ugh-pfl ughanze99/anthony-ughanze-portfolio

# pull the password from AWS Secrets Manager
echo "===== Retrieving Docker Hub password from AWS Secrets Manager ====="
docker_password=$(aws secretsmanager get-secret-value --secret-id Dockerhub --query SecretString --output text | jq -r .password)

# login to Docker Hub
sudo docker login --username=ughanze99 --password=$docker_password
sudo docker push ughanze99/anthony-ughanze-portfolio:latest

# Run the Docker container
echo "===== Running the Docker container ====="
sudo docker run -d -p 80:80 ughanze99/anthony-ughanze-portfolio:latest
