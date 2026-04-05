output "secret_name" {
  description = "The name of the secret"
  value       = aws_secretsmanager_secret.secret-manager.name
}

output "secret_arn" {
  description = "The ARN of the secret"
  value       = aws_secretsmanager_secret.secret-manager.arn
}

