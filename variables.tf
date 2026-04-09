variable "aws_region" {
  description = "AWS Region"
  default     = "eu-central-1"
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-034d74a15d5bb39e3"
}

variable "subnet_id" {
  description = "Haupt-Subnet fuer EC2"
  default     = "subnet-0108c179f715d3d71"
}

variable "subnet_ids" {
  description = "Alle Subnets fuer RDS Subnet Group"
  default     = ["subnet-0108c179f715d3d71", "subnet-0e1308e93d7f53639", "subnet-0716fc195456012a7"]
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI fuer eu-central-1"
  default     = "ami-014f11e8c26ed3e15"
}

variable "key_name" {
  description = "SSH Key Pair Name"
  default     = "masterschool-key"
}

variable "db_username" {
  description = "RDS Master Username"
  default     = "grocery_user"
}

variable "db_password" {
  description = "RDS Master Password"
  sensitive   = true
  default     = "GroceryRDS2026!"
}

variable "account_id" {
  description = "AWS Account ID fuer eindeutige S3 Bucket Namen"
  default     = "313414756158"
}
