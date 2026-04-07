resource "aws_secretsmanager_secret" "secret-manager" {
  name                    = var.name
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = local.common_tags
  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
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
  depends_on    = [aws_secretsmanager_secret.secret-manager, random_password.random-passwd]
}

