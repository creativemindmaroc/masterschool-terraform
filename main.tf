# ============================================================
# GroceryMate - AWS Infrastruktur als Code (Terraform)
# Masterschool Cloud Engineering - Woche 6
# Student: Mohamed Karim Oudrhiri
# ============================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

# ── SECURITY GROUP ─────────────────────────────────────────
resource "aws_security_group" "grocerymate_sg" {
  name        = "creativemind-sg"
  description = "Security Group fuer GroceryMate EC2 und RDS"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "PostgreSQL von gleicher SG (EC2 -> RDS)"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "creativemind-sg"
    Project = "GroceryMate"
    Week    = "6"
  }
}

# ── EC2 INSTANZ ────────────────────────────────────────────
resource "aws_instance" "grocerymate_ec2" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.grocerymate_sg.id]
  subnet_id              = var.subnet_id

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker git
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    cd /home/ec2-user
    git clone -b version2 https://github.com/AlejandroRomanIbanez/AWS_grocery.git
    chown -R ec2-user:ec2-user AWS_grocery/
  EOF

  tags = {
    Name    = "creativemind-ec2"
    Project = "GroceryMate"
    Week    = "6"
  }
}

# ── RDS SUBNET GROUP ───────────────────────────────────────
resource "aws_db_subnet_group" "grocerymate_subnet_group" {
  name       = "grocerymate-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name    = "grocerymate-subnet-group"
    Project = "GroceryMate"
  }
}

# ── RDS POSTGRESQL INSTANZ ─────────────────────────────────
resource "aws_db_instance" "grocerymate_rds" {
  identifier             = "grocerymate-db"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = "grocerymate_db"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.grocerymate_subnet_group.name
  vpc_security_group_ids = [aws_security_group.grocerymate_sg.id]
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  backup_retention_period = 0

  tags = {
    Name    = "grocerymate-db"
    Project = "GroceryMate"
    Week    = "6"
  }
}

# ── S3 BUCKET (Woche 7 vorbereitet) ───────────────────────
resource "aws_s3_bucket" "grocerymate_logs" {
  bucket = "grocerymate-logs-${var.account_id}"

  tags = {
    Name    = "grocerymate-logs"
    Project = "GroceryMate"
    Week    = "7"
  }
}

resource "aws_s3_bucket_versioning" "grocerymate_logs" {
  bucket = aws_s3_bucket.grocerymate_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}
