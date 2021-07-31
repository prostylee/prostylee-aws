variable "ENV" {
}

variable "PUBLIC_SUBNETS" {
  type = list
}

variable "DB_USER_NAME" {
  default = "postgres"
}

variable "DB_PASSWORD" {
}

variable "VPC_ID" {
}

resource "aws_db_subnet_group" "rds-prostylee-subnet-group" {
  name       = "rds-prostylee-subnet-group-${var.ENV}"
  subnet_ids = var.PUBLIC_SUBNETS

  tags = {
    Name         = "allow-rds"
    Environment  = var.ENV
    App          = "prostylee"
  }
}

# Security group
# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "allow-rds" {
  name   = "allow-rds-${var.ENV}"
  vpc_id = var.VPC_ID

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "allow-rds"
    Environment  = var.ENV
    App          = "prostylee"
  }
}

resource "aws_db_parameter_group" "rds-prostylee-params" {
  name   = "rds-prostylee-params-${var.ENV}"
  family = "postgres12"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

# Reference: https://learn.hashicorp.com/tutorials/terraform/aws-rds?in=terraform/aws
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "rds-prostylee-instance" {
  identifier             = "prostylee-${var.ENV}"
  name                   = "prostylee4${var.ENV}"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  max_allocated_storage = 100
  engine                 = "postgres"
  engine_version         = "12.5"
  username               = var.DB_USER_NAME
  password               = var.DB_PASSWORD
  db_subnet_group_name   = aws_db_subnet_group.rds-prostylee-subnet-group.name
  vpc_security_group_ids = [aws_security_group.allow-rds.id]
  parameter_group_name   = aws_db_parameter_group.rds-prostylee-params.name
  publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = false

  tags = {
    Name         = "rds-prostylee-instance"
    Environment  = var.ENV
    App          = "prostylee"
  }
}