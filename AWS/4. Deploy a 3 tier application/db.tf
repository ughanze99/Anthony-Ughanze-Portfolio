# RDS Database Instance
resource "aws_db_instance" "main" {
  identifier         = "${var.vpc_name}-db"
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = var.db_instance_type
  allocated_storage  = var.db_allocated_storage
  storage_type       = var.db_storage_type
  username           = var.db_username
  password           = var.db_password
  parameter_group_name = var.db_parameter_group_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
    db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot = true
}

# Security group for the RDS database
resource "aws_security_group" "db_sg" {
  name        = "${var.vpc_name}-db-sg"
  description = "Security group for the RDS database"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id] 
    }
}

# subnet group for the RDS database
resource "aws_db_subnet_group" "main" {
  name       = "${var.vpc_name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_db1.id, aws_subnet.private_db2.id]

  tags = {
    Name = "${var.vpc_name}-db-subnet-group"
  }
}

