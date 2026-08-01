<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ami"></a> [ami](#input\_ami) | AMI ID to launch the instance from | `string` | n/a | yes |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to assign a public IP address to the instance | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of an existing EC2 key pair to associate with the instance (optional) | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the EC2 instance, used for tagging | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of the root EBS volume, in GiB | `number` | `30` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | Type of the root EBS volume (e.g. gp3, gp2, io1) | `string` | `"gp3"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to associate with the instance | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet to launch the instance in | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the instance | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to run on instance launch (optional) | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the EC2 instance |
| <a name="output_id"></a> [id](#output\_id) | The ID of the EC2 instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP address of the instance |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP address of the instance, if assigned |
<!-- END_TF_DOCS -->