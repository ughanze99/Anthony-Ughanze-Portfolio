#Deploy the sever in the Houston subnet created for the company.
resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
    subnet_id     = aws_subnet.houston.id
    public_ip     = true
    security_groups = [aws_security_group.app_server_sg.id]

    #! Add a user_data script to install Docker and run the Docker container
    user_data = <<-EOF
                #!/bin/bash

                # Define variables
                # pull scripts from github
                deployscript=var.deploy_script_url 

                echo " === Downloading deployment script === "
                sudo curl -o "$target_dir/deployment.sh" "$deployscript"

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



