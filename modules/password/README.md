<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [random_password.vm_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | The length of the password to be generated | `number` | `8` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_password"></a> [password](#output\_password) | n/a |
<!-- END_TF_DOCS -->