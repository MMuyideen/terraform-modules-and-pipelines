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
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | A list of address spaces for the virtual network (e.g., ["10.0.0.0/16"]) | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the virtual network will be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the virtual network will be created | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnets to create in the virtual network | <pre>list(object({<br/>    name           = string<br/>    address_prefixes = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the virtual network | `map(string)` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the virtual network |
| <a name="output_name"></a> [name](#output\_name) | The name of the virtual network |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | A list of subnet IDs, in the same order as the input `subnets` variable |
<!-- END_TF_DOCS -->