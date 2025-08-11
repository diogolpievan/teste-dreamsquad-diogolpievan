output "backend_url" {
  description = "IP público da instância EC2"
  value       = aws_instance.test-dreamsquad-diogolpievan.public_ip
}
