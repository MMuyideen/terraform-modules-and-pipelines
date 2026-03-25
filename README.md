# Terraform Modules and Pipelines

A centralized repository containing reusable Terraform modules and CI/CD pipeline templates for deploying infrastructure across Azure and AWS. This repository is designed to be referenced by other projects to maintain consistent infrastructure-as-code patterns and deployment automation.

## Overview

This repository serves two primary purposes:

1. **Reusable Terraform Modules**: Encapsulated infrastructure components that can be referenced by other repositories
2. **Pipeline Templates**: Reusable CI/CD workflows for GitHub Actions and Azure DevOps that standardize deployment processes

By centralizing modules and pipelines, you ensure consistency across projects, reduce code duplication, and make infrastructure updates easier to manage.

## Repository Structure

```
terraform-modules-and-pipelines/
├── modules/
│   ├── azure/
│   │   ├── vm/
│   │   ├── app_service/
│   │   ├── storage_account/
│   │   ├── database/
│   │   ├── networking/
│   │   └── security/
│   ├── aws/
│   │   ├── ec2/
│   │   ├── s3/
│   │   ├── rds/
│   │   ├── iam/
│   │   └── networking/
│   └── common/
│       ├── monitoring/
│       └── logging/
├── pipeline-templates/
│   ├── github-actions/
│   │   ├── terraform-plan.yml
│   │   ├── terraform-apply.yml
│   │   └── terraform-destroy.yml
│   └── azure-devops/
│       ├── terraform-plan.yml
│       ├── terraform-apply.yml
│       └── terraform-destroy.yml
├── SECRETS-MANAGEMENT.md
├── README.md
├── LICENSE
└── .gitignore
```

## Prerequisites

Before using modules and pipelines from this repository, ensure you have:

- **Terraform**: Version 1.7 or later ([Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
- **GitHub Account**: For referencing modules and using GitHub Actions workflows (GitHub account: `mmuyideen`)
- **Azure Subscription** (if using Azure modules): With a service principal or OIDC-configured credentials
- **AWS Account** (if using AWS modules): With configured access keys or OIDC-configured credentials
- **Git**: For cloning and managing repositories

### Terraform Version Check

```bash
terraform version
```

Ensure the version is 1.7.0 or later. If you have an older version, upgrade using:

```bash
# macOS (Homebrew)
brew upgrade terraform

# Or download from https://developer.hashicorp.com/terraform/downloads
```

## Referencing Modules from Other Repositories

Terraform allows you to reference modules stored in remote Git repositories. To use a module from this repository, add it to your Terraform configuration:

### Basic Module Reference

```hcl
module "example_vm" {
  source = "git::https://github.com/mmuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=main"

  # Variables required by the module
  resource_group_name = "rg-prod"
  location            = "East US"
  vm_name             = "vm-app-prod"
  # ... additional variables
}
```

### Key Components of the Module Source URL

- `git::https://github.com/mmuyideen/terraform-modules-and-pipelines.git` — Repository URL
- `//modules/azure/vm` — Path to the module within the repository (note the double slashes)
- `?ref=main` — Git reference (branch, tag, or commit SHA)

### Using Specific Versions (Tags)

For production environments, always pin to a specific version using a git tag:

```hcl
module "production_vm" {
  source = "git::https://github.com/mmuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=v1.2.0"

  resource_group_name = "rg-prod"
  location            = "East US"
  vm_name             = "vm-app-prod"
}
```

### Referencing Specific Commits

For development or testing, you can reference a specific commit SHA:

```hcl
module "dev_vm" {
  source = "git::https://github.com/mmuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=abc123def456"

  resource_group_name = "rg-dev"
  location            = "East US"
  vm_name             = "vm-app-dev"
}
```

## Available Modules

### Azure Modules

#### `modules/azure/vm`
Provisions an Azure Virtual Machine with networking, security groups, and optional public IP.

**Key variables**: `resource_group_name`, `location`, `vm_name`, `vm_size`, `image_publisher`, `image_offer`, `image_sku`, `admin_username`, `admin_password`

**Example**:
```hcl
module "app_vm" {
  source = "git::https://github.com/mmuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=main"

  resource_group_name = aws.resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_name             = "vm-app-server"
  vm_size             = "Standard_D2s_v3"
}
```

#### `modules/azure/app_service`
Provisions an Azure App Service with app service plan.

**Key variables**: `resource_group_name`, `location`, `app_service_name`, `app_service_plan_name`, `sku_tier`, `sku_size`

#### `modules/azure/storage_account`
Provisions an Azure Storage Account with optional blob containers and tables.

**Key variables**: `resource_group_name`, `location`, `storage_account_name`, `account_tier`, `account_replication_type`

#### `modules/azure/database`
Provisions an Azure Database for MySQL or PostgreSQL.

**Key variables**: `resource_group_name`, `location`, `server_name`, `database_name`, `admin_username`, `admin_password`

#### `modules/azure/networking`
Provisions Virtual Networks, subnets, and network security groups.

**Key variables**: `resource_group_name`, `location`, `vnet_name`, `address_space`, `subnet_name`, `subnet_prefix`

#### `modules/azure/security`
Provisions Azure Key Vault and managed identities for secure secret management.

**Key variables**: `resource_group_name`, `location`, `key_vault_name`, `tenant_id`

### AWS Modules

#### `modules/aws/ec2`
Provisions EC2 instances with security groups and elastic IPs.

**Key variables**: `ami`, `instance_type`, `key_name`, `security_groups`, `tags`

#### `modules/aws/s3`
Provisions S3 buckets with versioning, encryption, and optional public access settings.

**Key variables**: `bucket_name`, `versioning_enabled`, `server_side_encryption_enabled`, `acl`

#### `modules/aws/rds`
Provisions RDS database instances (MySQL, PostgreSQL, MariaDB, Oracle, SQL Server).

**Key variables**: `engine`, `engine_version`, `instance_class`, `allocated_storage`, `db_name`, `master_username`, `master_password`

#### `modules/aws/iam`
Provisions IAM roles, policies, and service accounts.

**Key variables**: `role_name`, `assume_role_policy`, `policies`

#### `modules/aws/networking`
Provisions VPCs, subnets, internet gateways, and route tables.

**Key variables**: `vpc_cidr`, `subnet_cidrs`, `enable_nat_gateway`

### Common Modules

#### `modules/common/monitoring`
Provisions monitoring and alerting (Azure Monitor, CloudWatch).

**Key variables**: `resource_group_name` (Azure) or `region` (AWS), `alert_name`, `metric_name`

#### `modules/common/logging`
Provisions centralized logging (Log Analytics, CloudWatch Logs).

**Key variables**: `log_analytics_workspace_name` (Azure) or `log_group_name` (AWS)

## Using Pipeline Templates

Pipeline templates enable standardized CI/CD workflows across your projects. Two sets of templates are provided: GitHub Actions and Azure DevOps.

### GitHub Actions Workflow Templates

Store reusable workflows in `.github/workflows/` within your project repository and reference them from this repository.

#### Example: Using Terraform Plan Template

Create a file `.github/workflows/terraform-plan.yml` in your project:

```yaml
name: Terraform Plan

on:
  pull_request:
    paths:
      - 'terraform/**'
      - '.github/workflows/terraform-plan.yml'

jobs:
  terraform-plan:
    uses: mmuyideen/terraform-modules-and-pipelines/.github/workflows/terraform-plan.yml@main
    with:
      working-directory: terraform/
      terraform-version: "1.7.0"
    secrets:
      ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}
      ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
```

#### Example: Using Terraform Apply Template

Create a file `.github/workflows/terraform-apply.yml` in your project:

```yaml
name: Terraform Apply

on:
  push:
    branches:
      - main
    paths:
      - 'terraform/**'

jobs:
  terraform-apply:
    uses: mmuyideen/terraform-modules-and-pipelines/.github/workflows/terraform-apply.yml@main
    with:
      working-directory: terraform/
      terraform-version: "1.7.0"
      environment: production
    secrets:
      ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}
      ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
```

### Azure DevOps Pipeline Templates

Reference pipeline templates in your `azure-pipelines.yml`:

```yaml
trigger:
  - main

variables:
  - group: terraform-secrets

pool:
  vmImage: 'ubuntu-latest'

stages:
  - stage: TerraformPlan
    displayName: 'Terraform Plan'
    jobs:
      - template: pipeline-templates/azure-devops/terraform-plan.yml@terraform-modules-and-pipelines
        parameters:
          workingDirectory: $(System.DefaultWorkingDirectory)/terraform
          terraformVersion: '1.7.0'

  - stage: TerraformApply
    displayName: 'Terraform Apply'
    dependsOn: TerraformPlan
    condition: succeeded()
    jobs:
      - template: pipeline-templates/azure-devops/terraform-apply.yml@terraform-modules-and-pipelines
        parameters:
          workingDirectory: $(System.DefaultWorkingDirectory)/terraform
          terraformVersion: '1.7.0'
          environment: production
```

### Available Pipeline Templates

#### `terraform-plan.yml`
Validates Terraform configuration and generates a plan without applying changes.

**Parameters**:
- `working-directory`: Path to Terraform configuration
- `terraform-version`: Terraform version to use
- `backend-config`: (Optional) Backend configuration

**Output**: Plan summary in PR comments or pipeline logs

#### `terraform-apply.yml`
Applies approved Terraform configurations to infrastructure.

**Parameters**:
- `working-directory`: Path to Terraform configuration
- `terraform-version`: Terraform version to use
- `environment`: Deployment environment (dev/staging/prod)
- `auto-approve`: (Optional) Skip manual approval step

#### `terraform-destroy.yml`
Destroys infrastructure managed by Terraform.

**Parameters**:
- `working-directory`: Path to Terraform configuration
- `terraform-version`: Terraform version to use
- `confirm`: Requires explicit confirmation before destroying

## Secrets and Credentials

This repository references infrastructure credentials (Azure subscriptions, AWS access keys, etc.) through GitHub Secrets and Azure DevOps variable groups. **Do not commit secrets to this repository or any project repository.**

Comprehensive instructions for managing secrets are in [SECRETS-MANAGEMENT.md](./SECRETS-MANAGEMENT.md).

### Quick Start: Configure Secrets

1. **GitHub**:
   - Go to your organization/repository settings
   - Navigate to **Secrets and variables → Actions**
   - Add secrets like `ARM_SUBSCRIPTION_ID`, `ARM_CLIENT_SECRET`, etc.
   - Reference in workflows as `${{ secrets.SECRET_NAME }}`

2. **Azure DevOps**:
   - Go to **Pipelines → Library**
   - Create a variable group named `terraform-secrets`
   - Add variables and mark sensitive ones with the lock icon
   - Reference in pipelines as `$(variableName)`

See [SECRETS-MANAGEMENT.md](./SECRETS-MANAGEMENT.md) for detailed setup instructions, best practices, and recommended secret names.

## Contributing

To contribute improvements or new modules:

1. Create a feature branch from `main`
2. Add or update modules in the appropriate directory
3. Test modules thoroughly in a test environment
4. Submit a pull request with clear documentation
5. After approval, tag a release version (e.g., `v1.2.0`)

## Version Management

This repository uses semantic versioning for releases:

- **Major** (v1.0.0): Breaking changes to module interfaces
- **Minor** (v1.2.0): New features, backward compatible
- **Patch** (v1.2.1): Bug fixes

Always pin to a specific version or tag in production configurations:

```hcl
# Good: Pinned to specific version
source = "git::https://github.com/mmuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=v1.2.0"

# Avoid in production: Points to main branch and can change unexpectedly
source = "git::https://github.com/mmuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=main"
```

## Troubleshooting

### Module Source Not Found
- Verify the module path is correct (use double slashes: `//`)
- Check that the repository is public or you have proper Git credentials configured
- Ensure the `ref` (branch/tag) exists in the repository

### Terraform Init Failures
- Run `terraform get` to update module sources
- Check Git connectivity: `git ls-remote https://github.com/mmuyideen/terraform-modules-and-pipelines.git`
- Verify you're using Terraform 1.7+

### Secrets Not Available in Pipelines
- See [SECRETS-MANAGEMENT.md](./SECRETS-MANAGEMENT.md) for troubleshooting
- Verify secrets are created at the correct scope (organization vs. repository)
- Ensure the pipeline has permission to access the secrets

## License

This repository is licensed under the MIT License. See [LICENSE](./LICENSE) for details.

## Support

For issues, questions, or feature requests:

- Open an issue on this repository
- Contact the infrastructure team at your organization
- Review documentation and examples in the module directories

## References

- [Terraform Modules Documentation](https://developer.hashicorp.com/terraform/language/modules)
- [Terraform Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)
- [GitHub Actions Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [Azure DevOps Pipeline Templates](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/templates)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
