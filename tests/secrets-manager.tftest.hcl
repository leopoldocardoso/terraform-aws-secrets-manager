variables {
  name = "smtest-v2"
  random_password_length = 32
}

run "valid_create_secrets_manager" {
    command = apply
    assert {
      condition = aws_secretsmanager_secret.secret-manager.name == var.name
      error_message = "Invalid Name"
    }
    assert {
      condition = random_password.random-passwd[0].length == var.random_password_length
      error_message = "Invalid length"
    }
}

