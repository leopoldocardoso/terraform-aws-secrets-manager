variable "name" {
  description = "Friendly name of the new secret"
  type        = string
}

variable "description" {
  description = "A Description of the secret"
  type        = string
  default     = ""
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret."
  type        = number
  default     = 7
  validation {
    condition     = var.recovery_window_in_days >= 7 && var.recovery_window_in_days <= 30
    error_message = "Recovery window must be between 7 and 30 days."
  }
}

variable "create_random_password" {
  description = "Determines whether a random password will be generated and stored in the secret"
  type        = bool
  default     = true
}

variable "random_password_length" {
  description = "The length of the generated random password"
  type        = number
  default     = 32
  validation {
    condition     = var.random_password_length >= 32 && var.random_password_length <= 256
    error_message = "Password length must be between 32 and 256 characters"
  }
}

variable "special" {
  description = "Include special characters in the random password"
  type        = bool
  default     = true
}

variable "override_special" {
  description = "Supply your own list of special characters to use for string generation"
  type        = string
  default     = "!#$%&*()-_=+[]{}:?"
}


# variable "enable_rotation" {
#   description = "Determines whether secret rotation is enabled"
#   type        = bool
#   default     = false
# }

variable "tags" {
  description = "A map of tags to assign to the secret"
  type        = map(string)
  default     = {}
}


