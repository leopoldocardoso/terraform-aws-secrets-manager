# Random suffix generator for unique secret names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Example 1: Basic secret with random password (default settings)
module "secret_basic" {
  source = "../"

  name        = "my-secret-basic-${random_string.suffix.result}"
  description = "Basic secret with default settings"
}

# Example 2: Custom password length and special characters
module "secret_custom" {
  source = "../"

  name                   = "my-secret-custom-${random_string.suffix.result}"
  description            = "Secret with custom password length and special characters"
  random_password_length = 64
  override_special       = "!@#$%"
}

# Example 3: Secret without random password (bring your own)
module "secret_manual" {
  source = "../"

  name                    = "my-secret-manual-${random_string.suffix.result}"
  description             = "Secret without automatic password generation"
  create_random_password  = false
  recovery_window_in_days = 30
}

# Example 4: Secret with custom tags
module "secret_tagged" {
  source = "../"

  name        = "my-secret-production-${random_string.suffix.result}"
  description = "Production secret with custom tags"

  tags = {
    Environment = "production"
    Application = "api-backend"
    Team        = "platform"
    CostCenter  = "engineering"
  }
}

# Example 5: Secret without special characters
module "secret_no_special" {
  source = "../"

  name                   = "my-secret-alphanumeric-${random_string.suffix.result}"
  description            = "Secret with alphanumeric password only"
  random_password_length = 48
    special                = false
}

# Outputs to show the created secrets
output "basic_secret_arn" {
  description = "ARN of the basic secret"
  value       = module.secret_basic.secret_arn
}

output "custom_secret_name" {
  description = "Name of the custom secret"
  value       = module.secret_custom.secret_name
}

output "tagged_secret_arn" {
  description = "ARN of the tagged secret"
  value       = module.secret_tagged.secret_arn
}
