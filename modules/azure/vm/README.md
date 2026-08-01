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
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password for the administrator account. Required for Windows VMs and Linux VMs without SSH keys | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the administrator account on the virtual machine | `string` | `"azureuser"` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | Custom data to pass to the virtual machine (cloud-init for Linux or custom scripts for Windows) | `string` | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Whether to disable password authentication for Linux VMs (requires ssh\_public\_key) | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the VM will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the virtual machine | `string` | n/a | yes |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | A list of network interface IDs to attach to the virtual machine | `list(string)` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | The operating system disk configuration | <pre>object({<br/>    caching              = optional(string, "ReadWrite")<br/>    storage_account_type = optional(string, "Standard_LRS")<br/>  })</pre> | `{}` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The operating system type for the virtual machine ('linux' or 'windows') | `string` | `"linux"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the VM will be created | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | The size of the virtual machine (e.g., 'Standard\_B2s', 'Standard\_D2s\_v3') | `string` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | The source image reference for the virtual machine. If not specified, sensible defaults will be used based on os\_type | <pre>object({<br/>    publisher = optional(string)<br/>    offer     = optional(string)<br/>    sku       = optional(string)<br/>    version   = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The public SSH key for Linux VM authentication (required when disable\_password\_authentication is true) | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the virtual machine | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The username of the administrator account |
| <a name="output_id"></a> [id](#output\_id) | The ID of the virtual machine |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address of the virtual machine |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The public IP address associated with the virtual machine (if any) |
<!-- END_TF_DOCS -->