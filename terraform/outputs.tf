output "api_gateway_url" {
  description = "Base URL for the API Gateway"
  value       = aws_api_gateway_stage.prod.invoke_url
}

output "rds_endpoint" {
  description = "MySQL RDS endpoint"
  value       = aws_db_instance.mysql_rds.address
}
