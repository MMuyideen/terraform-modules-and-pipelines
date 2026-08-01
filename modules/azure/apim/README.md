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
| [azurerm_api_management.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the API Management service will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the API Management service | `string` | n/a | yes |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email address of the publisher of the API Management service | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of the publisher of the API Management service | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the API Management service will be created | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the API Management service (e.g., 'Developer\_1', 'Standard\_1', 'Premium\_1') | `string` | `"Developer_1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the API Management service | `map(string)` | `{}` | no |
| <a name="input_virtual_network_configuration"></a> [virtual\_network\_configuration](#input\_virtual\_network\_configuration) | Virtual network configuration for the API Management service (required when virtual\_network\_type is not 'None') | <pre>object({<br/>    subnet_id = string<br/>  })</pre> | `null` | no |
| <a name="input_virtual_network_type"></a> [virtual\_network\_type](#input\_virtual\_network\_type) | The virtual network type for the API Management service ('None', 'External', or 'Internal') | `string` | `"None"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_developer_portal_url"></a> [developer\_portal\_url](#output\_developer\_portal\_url) | The developer portal URL of the API Management service |
| <a name="output_gateway_url"></a> [gateway\_url](#output\_gateway\_url) | The gateway URL of the API Management service |
| <a name="output_id"></a> [id](#output\_id) | The ID of the API Management service |
| <a name="output_name"></a> [name](#output\_name) | The name of the API Management service |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The private IP addresses of the API Management service |
<!-- END_TF_DOCS -->