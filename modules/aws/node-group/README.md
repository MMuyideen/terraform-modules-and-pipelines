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
| [aws_eks_node_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | Type of Amazon Machine Image (AMI) associated with the EKS Node Group | `string` | `"AL2_x86_64"` | no |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Type of capacity associated with the EKS Node Group. Valid values: ON\_DEMAND, SPOT | `string` | `"ON_DEMAND"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired number of worker nodes | `number` | `2` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GiB for worker nodes | `number` | `20` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | List of instance types for the node group | `list(string)` | <pre>[<br/>  "t3.small"<br/>]</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version for the nodes | `string` | `"1.31"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of Kubernetes labels to apply to the nodes | `map(string)` | `{}` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of worker nodes | `number` | `2` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of worker nodes | `number` | `2` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | The name of the EKS node group | `string` | n/a | yes |
| <a name="input_node_role_arn"></a> [node\_role\_arn](#input\_node\_role\_arn) | The Amazon Resource Name (ARN) of the IAM role associated with the EKS Node Group | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to launch nodes in | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_node_group_name"></a> [node\_group\_name](#output\_node\_group\_name) | The name of the EKS Node Group |
| <a name="output_node_group_status"></a> [node\_group\_status](#output\_node\_group\_status) | The status of the EKS Node Group |
<!-- END_TF_DOCS -->