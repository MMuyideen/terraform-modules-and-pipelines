<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_length"></a> [length](#input\_length) | The length of the random string to generate | `number` | `4` | no |
| <a name="input_numeric"></a> [numeric](#input\_numeric) | Whether to include numeric digits in the random string | `bool` | `true` | no |
| <a name="input_upper"></a> [upper](#input\_upper) | Whether to include uppercase letters in the random string | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_result"></a> [result](#output\_result) | The generated random string, lowercase alphanumeric by default |
<!-- END_TF_DOCS -->