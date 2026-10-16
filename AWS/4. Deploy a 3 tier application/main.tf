# EC2 server1 that will host the application 
resource "aws_instance" "app_server1" {
  ami                    = var.app_server_ami
  instance_type          = var.app_server_instance_type
  subnet_id              = aws_subnet.private1.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.key_name

  # Create index.html file on the application servers
  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Web Application Deployed Successfully via Terraform Server 1!</h1>" > /var/www/html/index.html
              EOF
 
  tags = {
    Name = "${var.vpc_name}-app-server1"
  }
}


# EC2 server2 that will host the application 
resource "aws_instance" "app_server2" {
  ami                    = var.app_server_ami
  instance_type          = var.app_server_instance_type
  subnet_id              = aws_subnet.private2.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.key_name

  # Create index.html file on the application servers
  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Web Application Deployed Successfully via Terraform Server 2!</h1>" > /var/www/html/index.html
              EOF
  tags = {
    Name = "${var.vpc_name}-app-server2"
  }
}

# output the public dns name of the application load balancer
output "app_lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
