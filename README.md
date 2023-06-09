# terraform-aws-newrelic-metric-streams
Terraform module to create a firehose and cloud watch metric stream or logs to newrelic

<!-- Uncomment and replace with your module name
[![lint](https://github.com/flaconi/terraform-aws-newrelic-metric-streams/workflows/lint/badge.svg)](https://github.com/flaconi/terraform-aws-newrelic-metric-streams/actions?query=workflow%3Alint)
[![test](https://github.com/flaconi/terraform-aws-newrelic-metric-streams/workflows/test/badge.svg)](https://github.com/flaconi/terraform-aws-newrelic-metric-streams/actions?query=workflow%3Atest)
[![Tag](https://img.shields.io/github/tag/flaconi/terraform-aws-newrelic-metric-streams.svg)](https://github.com/flaconi/terraform-aws-newrelic-metric-streams/releases)
-->
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

<!-- TFDOCS_HEADER_START -->


<!-- TFDOCS_HEADER_END -->

<!-- TFDOCS_PROVIDER_START -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.4 |
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | ~> 3.25 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.5 |

<!-- TFDOCS_PROVIDER_END -->

<!-- TFDOCS_REQUIREMENTS_START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.4 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | ~> 3.25 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

 <!-- TFDOCS_REQUIREMENTS_END -->

 <!-- TFDOCS_INPUTS_START -->
## Required Inputs

The following input variables are required:

### <a name="input_newrelic_api_key_ssm_path"></a> [newrelic\_api\_key\_ssm\_path](#input\_newrelic\_api\_key\_ssm\_path)

Description: flag to decide to create lambda budgets or not

Type: `string`

### <a name="input_newrelic_account_id_ssm_path"></a> [newrelic\_account\_id\_ssm\_path](#input\_newrelic\_account\_id\_ssm\_path)

Description: flag to decide to create lambda budgets or not

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: n/a

Type: `string`

### <a name="input_type"></a> [type](#input\_type)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_kinesis_stream_arn"></a> [kinesis\_stream\_arn](#input\_kinesis\_stream\_arn)

Description: n/a

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: A mapping of tags to assign to all resources

Type: `map(string)`

Default: `{}`

<!-- TFDOCS_INPUTS_END -->

<!-- TFDOCS_OUTPUTS_START -->
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firehose_delivery_stream_arn"></a> [firehose\_delivery\_stream\_arn](#output\_firehose\_delivery\_stream\_arn) | n/a |

<!-- TFDOCS_OUTPUTS_END -->

## License

**[MIT License](LICENSE)**

Copyright (c) 2023 **[Flaconi GmbH](https://github.com/flaconi)**
