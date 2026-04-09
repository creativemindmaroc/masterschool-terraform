output "ec2_public_ip" {
  description = "Oeffentliche IP der EC2 Instanz"
  value       = aws_instance.grocerymate_ec2.public_ip
}

output "rds_endpoint" {
  description = "RDS Endpoint fuer App-Konfiguration"
  value       = aws_db_instance.grocerymate_rds.endpoint
}

output "s3_bucket_name" {
  description = "S3 Bucket Name fuer Logs"
  value       = aws_s3_bucket.grocerymate_logs.bucket
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.grocerymate_sg.id
}
