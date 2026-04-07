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
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | Prevent the secret from being destroyed by Terraform. Recommended for production secrets | `bool` | `false` | no |
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