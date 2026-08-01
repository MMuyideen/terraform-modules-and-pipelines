<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines the allocation method for this IP address. Possible values are Static or Dynamic | `string` | `"Dynamic"` | no |
| <a name="input_domain_name_label"></a> [domain\_name\_label](#input\_domain\_name\_label) | Label for the FQDN of the public IP (optional) | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the public IP will be created | `string` | n/a | yes |
| <a name="input_pip_name"></a> [pip\_name](#input\_pip\_name) | The name of the public IP | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the public IP will be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the public IP | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name (FQDN) of the public IP |
| <a name="output_id"></a> [id](#output\_id) | The ID of the public IP |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The IP address associated with the public IP |
<!-- END_TF_DOCS -->