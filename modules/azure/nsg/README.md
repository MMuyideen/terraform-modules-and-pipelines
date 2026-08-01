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
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the NSG will be created | `string` | n/a | yes |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | The name of the network security group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the NSG will be created | `string` | n/a | yes |
| <a name="input_security_rule"></a> [security\_rule](#input\_security\_rule) | A list of inbound security rules to create | <pre>list(object({<br/>    name                   = string<br/>    priority               = number<br/>    destination_port_range = string<br/>    protocol               = optional(string, "Tcp")<br/>    direction              = optional(string, "Inbound")<br/>    source_address_prefix  = optional(string, "*")<br/>    access                 = optional(string, "Allow")<br/>    source_port_range      = optional(string, "*")<br/>    destination_address_prefix = optional(string, "*")<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the network security group | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the network security group |
| <a name="output_name"></a> [name](#output\_name) | The name of the network security group |
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | The ID of the network security group |
<!-- END_TF_DOCS -->