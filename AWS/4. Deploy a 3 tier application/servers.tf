
# Security group for the application servers
resource "aws_security_group" "app_sg" {
  name        = "${var.vpc_name}-app-sg"
  description = "Security group for the application servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port                 = 80 
    to_port                   = 80
    protocol                  = "tcp"
    security_groups            = [aws_security_group.app_lb_sg.id]

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

# Generate a private key for the SSH key pair
resource "tls_private_key" "deployer" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# SSH key pair for the EC2 instances
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = tls_private_key.deployer.public_key_openssh
}

