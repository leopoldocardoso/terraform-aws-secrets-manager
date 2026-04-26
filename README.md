# terraform-aws-secrets-manager
Repositório dedicado ao projeto de conclusão de curso Descomplicando Terraform - Secrets Manager


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.39.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.39.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secret-manager](https://registry.terraform.io/providers/hashicorp/aws/6.39.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret-version](https://registry.terraform.io/providers/hashicorp/aws/6.39.0/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.random-passwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Determines whether a random password will be generated and stored in the secret | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A Description of the secret | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the new secret | `string` | n/a | yes |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | Supply your own list of special characters to use for string generation | `string` | `"!#$%&*()-_=+[]{}:?"` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | The length of the generated random password | `number` | `32` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that AWS Secrets Manager waits before it can delete the secret. | `number` | `7` | no |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in the random password | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | The ARN of the secret |
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | The name of the secret |
<!-- END_TF_DOCS -->


## Deployment Guide

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create Secrets Manager resources

### Step-by-Step Deployment

#### 1. Clone the repository
```bash
git clone <repository-url>
cd terraform-aws-secrets-manager
```

#### 2. Configure AWS credentials
```bash
# Option A: Using AWS CLI
aws configure

# Option B: Using environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

#### 3. Create a Terraform configuration file
Create a `main.tf` file in your project directory:

```hcl
module "my_secret" {
  source = "path/to/terraform-aws-secrets-manager"

  name        = "my-application-secret"
  description = "Secret for my application"
  
  # Optional: customize password settings
  random_password_length = 32
  special                = true
  
  # Optional: add tags
  tags = {
    Environment = "production"
    Application = "my-app"
  }
}

output "secret_arn" {
  value = module.my_secret.secret_arn
}
```

#### 4. Initialize Terraform
```bash
terraform init
```

This will download the required providers (AWS and Random).

#### 5. Review the execution plan
```bash
terraform plan
```

Review the resources that will be created.

#### 6. Apply the configuration
```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

#### 7. Verify the secret was created
```bash
# List secrets
aws secretsmanager list-secrets

# Get secret value (if random password was generated)
aws secretsmanager get-secret-value --secret-id my-application-secret
```

#### 8. (Optional) Update the secret value manually
If you created the secret without random password generation (`create_random_password = false`), you can set the value manually:

```bash
aws secretsmanager put-secret-value \
  --secret-id my-application-secret \
  --secret-string '{"username":"admin","password":"your-password"}'
```

### Cleanup

To destroy the created resources:

```bash
terraform destroy
```

**Note:** The secret will be scheduled for deletion based on the `recovery_window_in_days` value (default: 7 days). During this period, you can recover the secret if needed.

### Examples

Check the `examples/` directory for more usage examples:
- Basic secret creation
- Custom password settings
- Manual secret management
- Tagged secrets

### Troubleshooting

**Issue:** `Error: creating Secrets Manager Secret: InvalidRequestException: You can't create this secret because a secret with this name is already scheduled for deletion.`

**Solution:** Wait for the recovery window to pass, or restore the secret:
```bash
aws secretsmanager restore-secret --secret-id my-application-secret
```

**Issue:** `Error: Variables not allowed in lifecycle block`

**Solution:** The `prevent_destroy` setting cannot use variables. Apply it at the module level if needed.
