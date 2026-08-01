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
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_nsg_association"></a> [create\_nsg\_association](#input\_create\_nsg\_association) | Whether to associate var.nsg\_id with the NIC. Must be set explicitly (not derived from nsg\_id) because nsg\_id is often the computed output of a sibling resource and is not known until apply. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the NIC will be created | `string` | n/a | yes |
| <a name="input_nic_name"></a> [nic\_name](#input\_nic\_name) | The name of the network interface | `string` | n/a | yes |
| <a name="input_nsg_id"></a> [nsg\_id](#input\_nsg\_id) | The ID of the network security group to associate with the NIC (optional) | `string` | `null` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | The ID of the public IP address to assign to the NIC (optional) | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the NIC will be created | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet to attach the NIC to | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the network interface | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->