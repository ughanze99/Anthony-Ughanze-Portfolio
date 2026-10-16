## Create the IAM role for the instance to access the secret in AWS Secrets Manager

# Create a policy that allows the EC2 instance to access the secret in AWS Secrets Manager.
resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "secrets_manager_policy"  
  description = "Policy to allow EC2 instance to access secrets in AWS Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "arn:aws:secretsmanager:us-east-1:354509043603:secret:Dockerhub-K7GMRT"
      }
    ]
  })
}

# Create an IAM role for the EC2 instance to assume.
resource "aws_iam_role" "ec2_instance_role" {
  name = "ec2_instance_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the policy to the IAM role.
resource "aws_iam_role_policy_attachment" "secrets_manager_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

# Create an instance profile for the EC2 instance to use the IAM role.
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_instance_role.name
}

## Create the EC2 instance in the Houston subnet with the IAM role attached to it

#Deploy the sever in the Houston subnet created for the company.
resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
    subnet_id     = aws_subnet.houston.id
    security_groups = [aws_security_group.app_server_sg.id]  
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

    #! Add a user_data script to install Docker and run the Docker container
    user_data = <<-EOF
                #!/bin/bash

                # Define variables
                deployscript="https://raw.githubusercontent.com/ughanze99/Anthony-Ughanze-Portfolio/refs/heads/main/Scripts/Deployment/Deployment.sh"
                target_dir="/opt/anthony-ughanze-portfolio"
               
                # pull scripts from github
                echo " === Downloading deployment script === "
                sudo curl -fsSL "$deployscript" -o "$target_dir/deployment.sh"

                # Make the deployment script executable
                sudo chmod +x "$target_dir/deployment.sh"

                # Run the deployment script
                "$target_dir/deployment.sh"

                EOF


    tags = {
      Name = "App_Server"
    }
}

# Creates a security group for the EC2 instance to allow inbound traffic on port 80 (HTTP) and port 22 (SSH).
resource "aws_security_group" "app_server_sg" {
  name        = "app_server_sg"
  description = "Allow inbound traffic on port 80 and 22"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


