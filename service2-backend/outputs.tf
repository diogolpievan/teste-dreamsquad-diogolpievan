output "backend_url" {
  description = "IP público da instância EC2"
  value       = "PROD: ${aws_instance.fincheck-prod.public_ip}"
}
