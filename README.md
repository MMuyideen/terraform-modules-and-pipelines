# Terraform Modules and Pipelines

A centralized repository containing reusable Terraform modules and reusable GitHub Actions workflows/actions for deploying infrastructure across Azure, AWS, and GCP. This repository is designed to be referenced by other projects to maintain consistent infrastructure-as-code patterns and deployment automation.

## Overview

This repository serves two primary purposes:

1. **Reusable Terraform Modules**: Encapsulated infrastructure components for Azure, AWS, and GCP that can be referenced by other repositories
2. **Reusable GitHub Actions**: Composite actions (cloud login, Terraform init/validate/fmt) and callable workflows (plan/apply/destroy) that standardize deployment processes

By centralizing modules and workflows, you ensure consistency across projects, reduce code duplication, and make infrastructure updates easier to manage.

## Repository Structure

```
terraform-modules-and-pipelines/
├── modules/
│   ├── azure/
│   │   ├── apim/
│   │   ├── cdn-frontdoor/
│   │   ├── dns-zone/
│   │   ├── nic/
│   │   ├── nsg/
│   │   ├── public-ip/
│   │   ├── random/
│   │   ├── resource-group/
│   │   ├── storage-account/
│   │   ├── vm/
│   │   └── vnet/
│   ├── aws/
│   │   ├── ec2/
│   │   ├── eks/
│   │   ├── iam/
│   │   ├── nat-gw/
│   │   ├── node-group/
│   │   ├── security-group/
│   │   └── vpc/
│   ├── gcp/
│   └── password/
├── test/
│   ├── aws/
│   └── azure/
├── .github/
│   ├── actions/
│   │   ├── aws-login/
│   │   ├── azure-login/
│   │   ├── gcp-login/
│   │   └── terraform-init-validate-fmt/
│   └── workflows/
│       ├── terraform-plan.yml
│       ├── terraform-apply.yml
│       ├── terraform-destroy.yml
│       ├── aws-module-test.yaml
│       ├── azure-module-test.yaml
│       └── gcp-module-test.yaml
├── SECRETS-MANAGEMENT.md
├── README.md
├── LICENSE
└── .gitignore
```

## Prerequisites

Before using modules and workflows from this repository, ensure you have:

- **Terraform**: Version 1.7 or later ([Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
- **GitHub Account**: For referencing modules and using the reusable GitHub Actions workflows
- **Azure Subscription** (if using Azure modules): With a service principal or OIDC-configured credentials
- **AWS Account** (if using AWS modules): With OIDC-configured credentials (with static access keys as fallback)
- **GCP Project** (if using GCP modules): With Workload Identity Federation configured (with a service account key as fallback)
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
  source = "git::https://github.com/MMuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=main"

  # Variables required by the module
  resource_group_name = "rg-prod"
  location            = "East US"
  name                = "vm-app-prod"
  # ... additional variables
}
```

### Key Components of the Module Source URL

- `git::https://github.com/MMuyideen/terraform-modules-and-pipelines.git` — Repository URL
- `//modules/azure/vm` — Path to the module within the repository (note the double slashes)
- `?ref=main` — Git reference (branch, tag, or commit SHA)

### Using Specific Versions (Tags)

For production environments, always pin to a specific version using a git tag:

```hcl
module "production_vm" {
  source = "git::https://github.com/MMuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=v1.2.0"

  resource_group_name = "rg-prod"
  location            = "East US"
  name                = "vm-app-prod"
}
```

### Referencing Specific Commits

For development or testing, you can reference a specific commit SHA:

```hcl
module "dev_vm" {
  source = "git::https://github.com/MMuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=abc123def456"

  resource_group_name = "rg-dev"
  location            = "East US"
  name                = "vm-app-dev"
}
```

## Available Modules

Each module ships its own generated `README.md` (via `terraform-docs`) documenting its full set of inputs, outputs, resources, and requirements. The tables below are a summary — see the linked module directory for details.

### Azure Modules (`modules/azure/`)

| Module | Description |
| --- | --- |
| [`apim`](./modules/azure/apim) | Provisions an Azure API Management service (`azurerm_api_management`) |
| [`cdn-frontdoor`](./modules/azure/cdn-frontdoor) | Provisions an Azure Front Door (CDN) profile (`azurerm_cdn_frontdoor_profile`) |
| [`dns-zone`](./modules/azure/dns-zone) | Provisions a private DNS zone with A, CNAME, MX, and TXT records and virtual network links |
| [`nic`](./modules/azure/nic) | Provisions a network interface and associates it with a network security group |
| [`nsg`](./modules/azure/nsg) | Provisions a network security group |
| [`public-ip`](./modules/azure/public-ip) | Provisions a public IP address |
| [`random`](./modules/azure/random) | Generates a random string, e.g. for globally-unique resource names |
| [`resource-group`](./modules/azure/resource-group) | Provisions a resource group |
| [`storage-account`](./modules/azure/storage-account) | Provisions a storage account |
| [`vm`](./modules/azure/vm) | Provisions a Linux or Windows virtual machine |
| [`vnet`](./modules/azure/vnet) | Provisions a virtual network |

### AWS Modules (`modules/aws/`)

| Module | Description |
| --- | --- |
| [`ec2`](./modules/aws/ec2) | Provisions an EC2 instance |
| [`eks`](./modules/aws/eks) | Provisions an EKS cluster |
| [`iam`](./modules/aws/iam) | Provisions an IAM role and attaches policies to it |
| [`nat-gw`](./modules/aws/nat-gw) | Provisions a NAT gateway with an Elastic IP and private route table |
| [`node-group`](./modules/aws/node-group) | Provisions an EKS managed node group |
| [`security-group`](./modules/aws/security-group) | Provisions a security group |
| [`vpc`](./modules/aws/vpc) | Provisions a VPC with public/private subnets, an internet gateway, NAT gateway, and route tables |

### GCP Modules (`modules/gcp/`)

Reserved for future GCP modules. GCP login and module-test tooling (`.github/actions/gcp-login`, `.github/workflows/gcp-module-test.yaml`) is already in place, but no modules exist under this path yet.

### Shared Modules

| Module | Description |
| --- | --- |
| [`password`](./modules/password) | Generates a random password (`random_password`), e.g. for VM admin credentials |

## Using the Reusable GitHub Actions

This repository provides both composite actions (used inline as steps) and callable workflows (used with `workflow_call`).

### Composite Actions (`.github/actions/`)

| Action | Purpose |
| --- | --- |
| [`azure-login`](./.github/actions/azure-login) | Logs in to Azure via OIDC, falling back to service principal credentials JSON |
| [`aws-login`](./.github/actions/aws-login) | Assumes an AWS IAM role via OIDC, falling back to static access key/secret key |
| [`gcp-login`](./.github/actions/gcp-login) | Authenticates to GCP via Workload Identity Federation, falling back to a service account key |
| [`terraform-init-validate-fmt`](./.github/actions/terraform-init-validate-fmt) | Runs `terraform init`, `terraform validate`, and `terraform fmt -check -recursive` |

Example usage from another repository:

```yaml
- name: Azure Login
  uses: MMuyideen/terraform-modules-and-pipelines/.github/actions/azure-login@main
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
    creds: ${{ secrets.AZURE_CREDENTIALS }}

- name: Terraform Init, Validate, Format Check
  uses: MMuyideen/terraform-modules-and-pipelines/.github/actions/terraform-init-validate-fmt@main
  with:
    working-directory: terraform/
```

### Callable Workflows (`.github/workflows/`)

| Workflow | Purpose |
| --- | --- |
| [`terraform-plan.yml`](./.github/workflows/terraform-plan.yml) | Runs Terraform init/validate/plan and uploads the plan as an artifact |
| [`terraform-apply.yml`](./.github/workflows/terraform-apply.yml) | Logs in to the target cloud and runs `terraform apply -auto-approve` |
| [`terraform-destroy.yml`](./.github/workflows/terraform-destroy.yml) | Logs in to the target cloud and runs `terraform destroy -auto-approve` |

Common inputs across the apply/destroy workflows: `working_directory` (required), `cloud_provider` (required: `azure`, `aws`, or `gcp`), `environment` (default `dev`). `terraform-plan.yml` additionally accepts `terraform_version`, `backend_config`, and `var_file`.

Secrets accepted by these workflows (all optional, pass only what your `cloud_provider` needs): `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_SUBSCRIPTION_ID`, `AZURE_TENANT_ID`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`, `TF_VAR_admin_password`, `TF_VAR_subscription_id`.

#### Example: Using the Terraform Plan Workflow

```yaml
name: Terraform Plan

on:
  pull_request:
    paths:
      - 'terraform/**'

jobs:
  terraform-plan:
    uses: MMuyideen/terraform-modules-and-pipelines/.github/workflows/terraform-plan.yml@main
    with:
      working_directory: terraform/
      cloud_provider: azure
      terraform_version: "1.7.0"
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

#### Example: Using the Terraform Apply Workflow

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
    uses: MMuyideen/terraform-modules-and-pipelines/.github/workflows/terraform-apply.yml@main
    with:
      working_directory: terraform/
      cloud_provider: azure
      environment: production
    secrets:
      AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      AZURE_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
      AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

### Module Test Workflows

`aws-module-test.yaml`, `azure-module-test.yaml`, and `gcp-module-test.yaml` are internal CI workflows for this repository. They apply and then destroy the Terraform fixtures under `test/aws/`, `test/azure/`, and `test/gcp/` whenever files under the corresponding `modules/<provider>/` or `test/<provider>/` paths change, to catch breaking changes to the modules before merge.

## Secrets and Credentials

This repository references infrastructure credentials (Azure subscriptions, AWS access keys, GCP service accounts, etc.) through GitHub Secrets. **Do not commit secrets to this repository or any project repository.**

Comprehensive instructions for managing secrets are in [SECRETS-MANAGEMENT.md](./SECRETS-MANAGEMENT.md).

### Quick Start: Configure Secrets

1. Go to your repository (or organization) settings
2. Navigate to **Secrets and variables → Actions**
3. Add secrets such as `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `AWS_ACCESS_KEY_ID`, `GCP_SERVICE_ACCOUNT_KEY`, etc.
4. Reference them in workflows as `${{ secrets.SECRET_NAME }}`

See [SECRETS-MANAGEMENT.md](./SECRETS-MANAGEMENT.md) for detailed setup instructions, best practices, and recommended secret names.

## Generating Module Documentation

Each module's `README.md` is generated with [`terraform-docs`](https://terraform-docs.io/):

```bash
terraform-docs markdown table --output-file README.md --output-mode inject modules/<provider>/<module>
```

Re-run this after changing a module's variables, outputs, or resources to keep its documentation in sync.

## Contributing

To contribute improvements or new modules:

1. Create a feature branch from `main`
2. Add or update modules in the appropriate directory, and regenerate the module's `README.md` with `terraform-docs`
3. Test modules thoroughly using the fixtures under `test/<provider>/` (the module-test workflows will also run automatically on push to `main`)
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
source = "git::https://github.com/MMuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=v1.2.0"

# Avoid in production: Points to main branch and can change unexpectedly
source = "git::https://github.com/MMuyideen/terraform-modules-and-pipelines.git//modules/azure/vm?ref=main"
```

## Troubleshooting

### Module Source Not Found
- Verify the module path is correct (use double slashes: `//`)
- Check that the repository is public or you have proper Git credentials configured
- Ensure the `ref` (branch/tag) exists in the repository

### Terraform Init Failures
- Run `terraform get` to update module sources
- Check Git connectivity: `git ls-remote https://github.com/MMuyideen/terraform-modules-and-pipelines.git`
- Verify you're using Terraform 1.7+

### Secrets Not Available in Workflows
- See [SECRETS-MANAGEMENT.md](./SECRETS-MANAGEMENT.md) for troubleshooting
- Verify secrets are created at the correct scope (organization vs. repository)
- Ensure the workflow has permission to access the secrets

## License

This repository is licensed under the MIT License. See [LICENSE](./LICENSE) for details.

## Support

For issues, questions, or feature requests:

- Open an issue on this repository
- Review documentation and examples in the module directories

## References

- [Terraform Modules Documentation](https://developer.hashicorp.com/terraform/language/modules)
- [Terraform Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)
- [GitHub Actions Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [terraform-docs](https://terraform-docs.io/)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Google Cloud Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
