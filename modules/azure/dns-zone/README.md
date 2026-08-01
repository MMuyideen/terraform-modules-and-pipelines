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
| [azurerm_private_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) | resource |
| [azurerm_private_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_vnet_link"></a> [create\_vnet\_link](#input\_create\_vnet\_link) | Whether to link virtual\_network\_id to the DNS zone. Must be set explicitly (not derived from virtual\_network\_id) because that ID is often the computed output of a sibling resource and is not known until apply. | `bool` | `false` | no |
| <a name="input_dns_records"></a> [dns\_records](#input\_dns\_records) | A list of DNS records to create in the zone | <pre>list(object({<br/>    name    = string<br/>    type    = string<br/>    ttl     = optional(number, 3600)<br/>    records = optional(list(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | The name of the private DNS zone | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the DNS zone will be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the DNS zone | `map(string)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The ID of the virtual network to link to the DNS zone (optional) | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the private DNS zone |
| <a name="output_name"></a> [name](#output\_name) | The name of the private DNS zone |
<!-- END_TF_DOCS -->