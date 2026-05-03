# terraform-aws-secrets-manager

Módulo Terraform para gerenciar secrets no AWS Secrets Manager com geração automática de senhas aleatórias e nomes únicos.

## 🚀 Características

- ✅ Criação automática de secrets no AWS Secrets Manager
- ✅ Geração automática de senhas seguras com `random_password`
- ✅ Nomes únicos para secrets usando sufixo aleatório (`random_string`)
- ✅ Configuração flexível de comprimento e caracteres especiais
- ✅ Suporte a tags personalizadas
- ✅ Janela de recuperação configurável
- ✅ Opção para gerenciar valores de secrets manualmente

## 📋 Pré-requisitos

- Terraform >= 1.0
- AWS CLI configurado com credenciais apropriadas
- Permissões IAM para criar recursos no Secrets Manager

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
| [random_string.secret_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

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

## 🎯 Uso Rápido

```hcl
module "my_secret" {
  source = "github.com/seu-usuario/terraform-aws-secrets-manager"

  name        = "my-application-secret"
  description = "Secret para minha aplicação"
}

output "secret_arn" {
  value = module.my_secret.secret_arn
}
```

**Nota:** O módulo automaticamente adiciona um sufixo aleatório ao nome (ex: `my-application-secret-a1b2c3`) para garantir unicidade.


## 📦 Deployment Guide

### Passo 1: Configurar Credenciais AWS

Existem várias formas de configurar suas credenciais AWS:

**Opção A: AWS CLI (Recomendado)**
```bash
aws configure
# Insira: Access Key ID, Secret Access Key, região padrão
```

**Opção B: Variáveis de Ambiente**
```bash
export AWS_ACCESS_KEY_ID="sua-access-key"
export AWS_SECRET_ACCESS_KEY="sua-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

**Opção C: AWS Profile**
```bash
export AWS_PROFILE="seu-profile"
```

### Passo 2: Clonar e Preparar o Módulo

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/terraform-aws-secrets-manager.git
cd terraform-aws-secrets-manager

# Inicialize o Terraform
terraform init
```

### Passo 3: Criar Configuração Básica

Crie um arquivo `terraform.tfvars` ou use o módulo diretamente:

**Exemplo 1: Secret Básico com Senha Automática**
```hcl
module "app_secret" {
  source = "./terraform-aws-secrets-manager"

  name        = "my-app-database"
  description = "Credenciais do banco de dados da aplicação"
}
```

**Exemplo 2: Secret com Senha Customizada**
```hcl
module "api_secret" {
  source = "./terraform-aws-secrets-manager"

  name                   = "my-api-key"
  description            = "API Key para serviço externo"
  random_password_length = 64
  special                = false  # Apenas alfanumérico
}
```

**Exemplo 3: Secret Manual (Sem Geração Automática)**
```hcl
module "manual_secret" {
  source = "./terraform-aws-secrets-manager"

  name                   = "my-manual-secret"
  description            = "Secret com valor definido manualmente"
  create_random_password = false
  recovery_window_in_days = 30
}
```

**Exemplo 4: Secret com Tags para Produção**
```hcl
module "prod_secret" {
  source = "./terraform-aws-secrets-manager"

  name        = "production-db-credentials"
  description = "Credenciais do banco de produção"
  
  tags = {
    Environment = "production"
    Application = "ecommerce"
    Team        = "backend"
    ManagedBy   = "terraform"
    CostCenter  = "engineering"
  }
}
```

### Passo 4: Planejar e Aplicar

```bash
# Visualize o que será criado
terraform plan

# Aplique as mudanças
terraform apply

# Confirme digitando: yes
```

### Passo 5: Verificar o Secret Criado

```bash
# Listar todos os secrets
aws secretsmanager list-secrets

# Ver detalhes do secret (sem o valor)
aws secretsmanager describe-secret --secret-id <nome-do-secret>

# Obter o valor do secret
aws secretsmanager get-secret-value --secret-id <nome-do-secret>
```

### 🧹 Limpeza e Remoção

```bash
# Destruir todos os recursos
terraform destroy

# Confirme digitando: yes
```

**⚠️ Importante:** O secret será agendado para exclusão com base no `recovery_window_in_days` (padrão: 7 dias). Durante este período, você pode recuperá-lo:

```bash
# Recuperar secret agendado para exclusão
aws secretsmanager restore-secret --secret-id my-app-database-a1b2c3

# Forçar exclusão imediata (use com cuidado!)
aws secretsmanager delete-secret \
  --secret-id my-app-database-a1b2c3 \
  --force-delete-without-recovery
```

## 📚 Exemplos Completos

Confira o diretório `examples/` para casos de uso completos:

- **Basic**: Secret simples com configurações padrão
- **Custom**: Senha com comprimento e caracteres personalizados
- **Manual**: Secret sem geração automática de senha
- **Tagged**: Secret com tags para organização
- **No Special**: Senha apenas alfanumérica

## 🔧 Troubleshooting

### Erro: Secret com mesmo nome já existe

**Problema:**
```
Error: creating Secrets Manager Secret: InvalidRequestException: 
You can't create this secret because a secret with this name is already scheduled for deletion.
```

**Solução:**
```bash
# Opção 1: Restaurar o secret existente
aws secretsmanager restore-secret --secret-id <nome-do-secret>

# Opção 2: Aguardar o período de recuperação (7 dias por padrão)

# Opção 3: Deletar imediatamente (cuidado!)
aws secretsmanager delete-secret \
  --secret-id <nome-do-secret> \
  --force-delete-without-recovery
```

### Erro: Permissões Insuficientes

**Problema:**
```
Error: AccessDeniedException: User is not authorized to perform: secretsmanager:CreateSecret
```

**Solução:** Adicione as seguintes permissões IAM:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:CreateSecret",
        "secretsmanager:DeleteSecret",
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutSecretValue",
        "secretsmanager:TagResource"
      ],
      "Resource": "*"
    }
  ]
}
```

### Erro: Nome do Secret Muito Longo

**Problema:**
```
Error: InvalidParameterException: The secret name can contain ASCII letters, 
numbers, and the following characters: /_+=.@- and must not exceed 512 characters.
```

**Solução:** Use um nome mais curto para a variável `name`. Lembre-se que o módulo adiciona um sufixo de 6 caracteres automaticamente.

### Teste Falhando no Terraform Test

**Problema:**
```
Error: Test assertion failed
condition = can(regex("^${var.name}-", aws_secretsmanager_secret.secret-manager.name))
```

**Solução:** Verifique se o `main.tf` está usando `${var.name}` corretamente (não `"var.name"` como string literal).

## 🧪 Executando Testes

```bash
# Executar testes do Terraform
terraform test

# Validar configuração
terraform validate

# Formatar código
terraform fmt -recursive
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

Projeto de conclusão de curso - Descomplicando Terraform

---

**⭐ Se este módulo foi útil, considere dar uma estrela no repositório!**
