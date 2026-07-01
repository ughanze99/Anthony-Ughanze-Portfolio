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

echo "===== Verifying Docker installation ====="
docker --version

# Create the docker-compose.yml file


# Build the docker image from the Dockerfile
sudo docker build -t tony-ugh-pfl . 

