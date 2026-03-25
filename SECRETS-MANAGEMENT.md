# Secrets Management Guide for Terraform Deployments

## Overview

Sensitive values such as passwords, API keys, subscription IDs, client secrets, and access tokens should **never** be committed to version control or stored in `.tfvars` files. Exposing these credentials in your repository—even in private repos—poses significant security risks:

- **Accidental exposure**: Secrets can be leaked through logs, error messages, or repository access changes
- **Historical records**: Git maintains a complete history; removing a secret later doesn't erase it from git history
- **Supply chain attacks**: Compromised credentials can be used to access infrastructure or deploy malicious code
- **Compliance violations**: Most regulatory frameworks (SOC 2, PCI-DSS, HIPAA) require secrets to be stored separately from code

This guide covers best practices for managing secrets using **GitHub Secrets** and **Azure DevOps Variable Groups**.

---

## GitHub Secrets Setup

GitHub Secrets is the native solution for storing sensitive values in GitHub Actions workflows. All secrets are encrypted at rest and masked in logs.

### Organization-Level Secrets

Organization-level secrets are shared across all repositories in the GitHub organization. Use these for infrastructure-wide credentials that multiple projects need.

**To create an organization secret:**
1. Navigate to your GitHub organization settings
2. Go to **Settings → Secrets and variables → Actions**
3. Click **New organization secret**
4. Provide:
   - **Name**: `ARM_SUBSCRIPTION_ID` (example)
   - **Value**: Your Azure subscription ID
   - **Repository access**: Select which repos can access this secret (recommended: all repositories needing Azure access)
5. Click **Add secret**

**Recommended organization-level secrets:**

| Secret Name | Description | Example Value |
|---|---|---|
| `ARM_SUBSCRIPTION_ID` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `ARM_TENANT_ID` | Azure AD tenant ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `ARM_CLIENT_ID` | Service principal application ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `ARM_CLIENT_SECRET` | Service principal secret (consider OIDC instead) | `sensitive-secret-value` |
| `AWS_ACCESS_KEY_ID` | AWS access key | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |

### Repository-Level Secrets

Repository-level secrets are specific to a single repository and override organization secrets if they have the same name.

**To create a repository secret:**
1. Navigate to your repository
2. Go to **Settings → Secrets and variables → Actions**
3. Click **New repository secret**
4. Provide:
   - **Name**: `TF_VAR_admin_password` (example)
   - **Value**: The sensitive value (e.g., VM admin password)
5. Click **Add secret**

Use repository secrets for project-specific values that should not be shared across your organization.

### Environment Secrets

Environment secrets allow you to maintain different values for different deployment environments (dev, staging, production) within a single repository.

**To create an environment secret:**
1. Navigate to your repository
2. Go to **Settings → Environments**
3. Select or create an environment (e.g., `production`)
4. Under **Environment secrets**, click **Add secret**
5. Provide the name and value (e.g., `TF_VAR_db_password`)
6. Click **Add secret**

In your workflows, reference environment secrets by adding `environment:` to your job:
```yaml
jobs:
  deploy:
    environment: production
    runs-on: ubuntu-latest
    steps:
      - run: terraform apply
        env:
          TF_VAR_db_password: ${{ secrets.TF_VAR_db_password }}
```

### Referencing Secrets in Workflows

#### Using Secrets Directly

Reference secrets in workflow files using the syntax `${{ secrets.SECRET_NAME }}`:

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Configure Azure credentials
        run: |
          az login \
            --service-principal \
            -u ${{ secrets.ARM_CLIENT_ID }} \
            -p ${{ secrets.ARM_CLIENT_SECRET }} \
            --tenant ${{ secrets.ARM_TENANT_ID }}
```

#### Passing Secrets as Terraform Variables

Terraform reads variables prefixed with `TF_VAR_` from environment variables. Pass secrets as environment variables in your workflow:

```yaml
jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: "1.7.0"

      - name: Apply Terraform
        env:
          TF_VAR_admin_password: ${{ secrets.ADMIN_PASSWORD }}
          TF_VAR_vm_name: ${{ secrets.VM_NAME }}
          ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
          ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}
          ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
          ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
        run: |
          terraform init
          terraform plan
          terraform apply -auto-approve
```

### Recommended: OIDC Setup for Azure

Instead of using a client secret (`ARM_CLIENT_SECRET`), GitHub recommends using **OpenID Connect (OIDC)** with federated credentials. This approach eliminates the need to store a long-lived secret.

**To set up OIDC for Azure:**

1. **Create a service principal** (if you don't have one):
   ```bash
   az ad sp create-for-rbac \
     --name "github-actions-sp" \
     --role Contributor \
     --scopes /subscriptions/{subscription-id}
   ```
   Save the output (`appId`, `tenant`).

2. **Create a federated credential** for your GitHub repository:
   ```bash
   az ad app federated-credential create \
     --id {app-id} \
     --parameters credential.json
   ```
   Where `credential.json` contains:
   ```json
   {
     "name": "github-actions-repo",
     "issuer": "https://token.actions.githubusercontent.com",
     "subject": "repo:mmuyideen/terraform-modules-and-pipelines:ref:refs/heads/main",
     "description": "GitHub Actions OIDC token",
     "audiences": ["api://AzureADTokenExchange"]
   }
   ```

3. **In your workflow**, use `azure/login` action with `client-id`:
   ```yaml
   - uses: azure/login@v1
     with:
       client-id: ${{ secrets.AZURE_CLIENT_ID }}
       tenant-id: ${{ secrets.AZURE_TENANT_ID }}
       subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
   ```

This approach is more secure because:
- No long-lived secrets to rotate
- Credentials are automatically issued per-workflow-run
- Federated credentials are tied to your GitHub repository

---

## Azure DevOps Variable Groups Setup

Variable groups in Azure DevOps centralize secret management for pipelines. They can be linked to Azure Key Vault for additional security.

### Creating a Variable Group

1. Navigate to your Azure DevOps project
2. Go to **Pipelines → Library**
3. Click **+ Variable group**
4. Enter:
   - **Name**: `terraform-secrets` (or similar)
   - **Description**: Purpose of the group
5. Click **Save**

### Adding Variables to a Group

1. In the variable group, click **+ Add**
2. Provide the variable name and value
3. To mark it as secret (masked in logs), click the **lock icon** next to the value
4. Click **OK** and then **Save**

**Example variables:**
- `ARM_SUBSCRIPTION_ID`: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (not secret)
- `ARM_TENANT_ID`: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (not secret)
- `ARM_CLIENT_ID`: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` (not secret)
- `ARM_CLIENT_SECRET`: `sensitive-value` (mark as secret)
- `TF_VAR_admin_password`: `password123` (mark as secret)

### Linking to Azure Key Vault

For enhanced security, link your variable group to an Azure Key Vault:

1. In the variable group, click **Link secrets from an Azure key vault**
2. Select your Azure subscription and key vault
3. Click **Add** to select which key vault secrets to include
4. The variables will be automatically fetched from Key Vault at pipeline runtime

### Referencing Variables in Pipelines

Use the syntax `$(variableName)` to reference a variable group variable in your pipeline:

```yaml
trigger:
  - main

variables:
  - group: terraform-secrets

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: TerraformTaskV4@4
    inputs:
      provider: 'azurerm'
      command: 'init'
      backendServiceArm: 'Azure Connection'
      backendAzureRmResourceGroupName: 'rg-terraform'
      backendAzureRmStorageAccountName: 'tfstate'
      backendAzureRmContainerName: 'state'
      backendAzureRmKey: 'prod.tfstate'

  - task: TerraformTaskV4@4
    inputs:
      provider: 'azurerm'
      command: 'plan'
      workingDirectory: '$(System.DefaultWorkingDirectory)'
    env:
      TF_VAR_admin_password: $(TF_VAR_admin_password)
      ARM_SUBSCRIPTION_ID: $(ARM_SUBSCRIPTION_ID)
      ARM_TENANT_ID: $(ARM_TENANT_ID)
      ARM_CLIENT_ID: $(ARM_CLIENT_ID)
      ARM_CLIENT_SECRET: $(ARM_CLIENT_SECRET)

  - task: TerraformTaskV4@4
    inputs:
      provider: 'azurerm'
      command: 'apply'
      workingDirectory: '$(System.DefaultWorkingDirectory)'
    env:
      TF_VAR_admin_password: $(TF_VAR_admin_password)
      ARM_SUBSCRIPTION_ID: $(ARM_SUBSCRIPTION_ID)
      ARM_TENANT_ID: $(ARM_TENANT_ID)
      ARM_CLIENT_ID: $(ARM_CLIENT_ID)
      ARM_CLIENT_SECRET: $(ARM_CLIENT_SECRET)
```

### Passing Secrets as Terraform Variables

To expose variables as Terraform variables, prefix them with `TF_VAR_` in your pipeline environment:

```yaml
steps:
  - bash: |
      terraform plan
    env:
      TF_VAR_admin_password: $(TF_VAR_admin_password)
      TF_VAR_vm_name: $(VM_NAME)
```

---

## Recommended Secrets Reference Table

Use this table as a checklist for secrets that should be configured across your organization and repositories:

| Secret Name | Description | Scope | Used By | Notes |
|---|---|---|---|---|
| `ARM_SUBSCRIPTION_ID` | Azure subscription ID | Organization | All Azure projects | Non-sensitive; can be stored in code |
| `ARM_TENANT_ID` | Azure AD tenant ID | Organization | All Azure projects | Non-sensitive; can be stored in code |
| `ARM_CLIENT_ID` | Azure service principal app ID | Organization | All Azure projects | Non-sensitive; can be stored in code |
| `ARM_CLIENT_SECRET` | Azure service principal secret | Organization | All Azure projects | **Secret**; consider OIDC instead |
| `AWS_ACCESS_KEY_ID` | AWS access key ID | Organization | All AWS projects | **Secret** |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key | Organization | All AWS projects | **Secret** |
| `TF_VAR_admin_password` | VM/database admin password | Repository | VM/database projects | **Secret**; environment-specific |
| `TF_VAR_db_password` | Database password | Repository | Database projects | **Secret**; environment-specific |
| `TF_VAR_api_key` | External API key | Repository | Projects using external APIs | **Secret** |
| `GITHUB_TOKEN` | GitHub personal access token (if needed) | Repository | Any project needing GitHub API access | **Secret**; auto-provided in workflows |

---

## Best Practices

### 1. Use OIDC Over Client Secrets
- Prefer OpenID Connect (OIDC) / workload identity federation for Azure and AWS
- Eliminates the need for long-lived secrets
- Each workflow run receives a short-lived credential token
- Reduces the blast radius of a compromise

### 2. Rotate Secrets Regularly
- Establish a rotation schedule (e.g., quarterly)
- Document rotation procedures in your team's runbook
- For client secrets, update both in your identity provider and GitHub/Azure DevOps simultaneously

### 3. Use Environment-Scoped Secrets for Multi-Environment Deployments
- Create separate secrets for development, staging, and production
- Use GitHub environment secrets or Azure DevOps environment-specific variable groups
- Never reuse production credentials across environments

### 4. Never Echo Secrets in Logs
- GitHub automatically masks secrets in logs, but:
  - Be cautious with commands that might inadvertently reveal secrets
  - Use `--secret` flags when available (e.g., `terraform apply -json` with proper redaction)
  - Review logs to ensure no credentials appear

### 5. Enable GitHub Secret Scanning
- GitHub automatically scans for commits containing known secret patterns
- Enable secret scanning in your repository settings
- Configure push protection to block commits with detected secrets

### 6. Limit Secret Access
- Only grant secret access to repositories and teams that need it
- Use GitHub's repository access controls to minimize exposure
- Audit who can access variable groups in Azure DevOps

### 7. Use Short-Lived Credentials
- Prefer credentials with expiration dates
- For service principals, enable expiration on certificates/secrets
- For API keys, set expiration dates when possible

### 8. Document Your Secrets Architecture
- Maintain a runbook of all secrets, their purpose, and rotation schedule
- Include information on which secrets are environment-specific
- Keep this documentation up-to-date as your infrastructure evolves

### 9. Monitor Secret Usage
- Review audit logs in GitHub and Azure DevOps for unauthorized access attempts
- Set up alerts for unusual authentication patterns
- Investigate and rotate compromised secrets immediately

### 10. Secure Your Identity Provider
- Enforce multi-factor authentication (MFA) for your GitHub and Azure DevOps accounts
- Use strong, unique passwords
- Regularly review and revoke inactive personal access tokens

---

## Troubleshooting

### Secrets Not Appearing in Workflow
- Ensure the secret is created at the correct scope (organization vs. repository vs. environment)
- Check that the repository has access to organization-level secrets
- Verify the exact secret name (secrets are case-sensitive)
- Confirm the secret hasn't been accidentally deleted

### Terraform Not Picking Up Variables
- Ensure environment variables are prefixed with `TF_VAR_` for Terraform to recognize them
- Verify the `env:` section of your workflow step includes all necessary variables
- Check that variable names in Terraform match the secret names (case-sensitive)

### Azure/AWS Authentication Failures
- For Azure, ensure all three values are set: `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`, and `ARM_CLIENT_ID` (+ secret if not using OIDC)
- For AWS, ensure both `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are present
- Verify the service principal or IAM user has the required permissions

### Secret Accidentally Committed to Git
- Immediately rotate the compromised secret
- Use tools like `git-filter-repo` or `BFG Repo-Cleaner` to remove it from history
- Force-push the cleaned history
- Consider your secret compromised; treat it as if someone has access

---

## References

- [GitHub Actions: Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitHub Actions: OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- [Azure DevOps: Variable groups](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/variable-groups)
- [Azure DevOps: Link secrets from Azure Key Vault](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/variable-groups)
- [Terraform: Environment variables](https://developer.hashicorp.com/terraform/cli/config/environment-variables)
- [OWASP: Secret Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
