# Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "${var.vpc_name}-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_lb_sg.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
}

# Security Group for the Application Load Balancer
resource "aws_security_group" "app_lb_sg" {
  name        = "${var.vpc_name}-app-lb-sg"
  description = "Security group for the application load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
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

# Target Group for the Application Servers
resource "aws_lb_target_group" "app_target_group" {
  name     = "${var.vpc_name}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Listener for the Application Load Balancer
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port               = 80
  protocol           = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}

# Register the Application Server1 with the Target Group
resource "aws_lb_target_group_attachment" "app_server1_attachment" {
  target_group_arn = aws_lb_target_group.app_target_group.arn
  target_id        = aws_instance.app_server1.id
  port             = 80
}

# Register the Application Server2 with the Target Group
resource "aws_lb_target_group_attachment" "app_server2_attachment" {
  target_group_arn = aws_lb_target_group.app_target_group.arn
  target_id        = aws_instance.app_server2.id
  port             = 80
}