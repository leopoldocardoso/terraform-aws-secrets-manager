variables {
  name                   = "smtest"
  random_password_length = 32
  prevent_destroy        = true
}

run "valid_create_secrets_manager" {
  command = apply
  assert {
    condition     = can(regex("^${var.name}-", aws_secretsmanager_secret.secret-manager.name))
    error_message = "Secret name should start with the provided name prefix"
  }
  assert {
    condition     = random_password.random-passwd[0].length == var.random_password_length
    error_message = "Invalid length"
  }
}

