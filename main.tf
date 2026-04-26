resource "random_pet" "secret_suffix" {
  length    = 2
  separator = "-"
}
resource "aws_secretsmanager_secret" "secret-manager" {
  name                    = "${var.name}-${random_pet.secret_suffix.id}"
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days
}

resource "random_password" "random-passwd" {
  count            = var.create_random_password ? 1 : 0
  length           = var.random_password_length
  special          = var.special
  override_special = var.override_special
}

resource "aws_secretsmanager_secret_version" "secret-version" {
  count         = var.create_random_password ? 1 : 0
  secret_id     = aws_secretsmanager_secret.secret-manager.id
  secret_string = random_password.random-passwd[0].result
}

