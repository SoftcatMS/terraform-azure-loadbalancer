# terraform-azure-loadbalancer

A terraform module to provide load balancers in Azure with the following characteristics:

Ability to specify `public` or `private` loadbalancer using: `var.type`. Default is public.
Specify subnet to use for the loadbalancer: `frontend_subnet_id`
For `private` loadbalancer, specify the private ip address using `frontend_private_ip_address`
Specify the type of the private ip address with `frontend_private_ip_address_allocation`, `Dynamic` or `Static` , default is `Dynamic`

Based of original module: https://github.com/Azure/terraform-azurerm-loadbalancer


It supports creating:

- Public IP
- Load Balancer
- Backend Address Pool
- Nat Rule
- Load Balancer Probe
- Load Balancer Rule


## Usage Examples
Review the examples folder: [examples](./examples)


## Deployment
Perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure


use terraform-docs to create Inputs and Outpus documentation  [terraform-docs](https://github.com/terraform-docs/terraform-docs)

`terraform-docs markdown .`


## Requirements
### Installed Software
The following dependencies must be installed on the development system:

- [Terraform](https://www.terraform.io/downloads.html) 

Azure  
- [Terraform Provider for Azure](https://github.com/hashicorp/terraform-provider-azurerm)
- CLI Tool [az](https://docs.microsoft.com/en-us/cli/azure/)


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.azlb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.azlb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_rule.azlb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_probe.azlb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.azlb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_public_ip.azlb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azlb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | (Required) Defines how an IP address is assigned. Options are Static or Dynamic. | `string` | `"Static"` | no |
| <a name="input_frontend_name"></a> [frontend\_name](#input\_frontend\_name) | (Required) Specifies the name of the frontend ip configuration. | `string` | `"myPublicIP"` | no |
| <a name="input_frontend_private_ip_address"></a> [frontend\_private\_ip\_address](#input\_frontend\_private\_ip\_address) | (Optional) Private ip address to assign to frontend. Use it with type = private | `string` | `""` | no |
| <a name="input_frontend_private_ip_address_allocation"></a> [frontend\_private\_ip\_address\_allocation](#input\_frontend\_private\_ip\_address\_allocation) | (Optional) Frontend ip allocation type (Static or Dynamic) | `string` | `"Dynamic"` | no |
| <a name="input_frontend_subnet_id"></a> [frontend\_subnet\_id](#input\_frontend\_subnet\_id) | (Optional) Frontend subnet id to use when in private mode | `string` | `""` | no |
| <a name="input_lb_port"></a> [lb\_port](#input\_lb\_port) | Protocols to be used for lb rules. Format as [frontend\_port, protocol, backend\_port] | `map(any)` | `{}` | no |
| <a name="input_lb_probe"></a> [lb\_probe](#input\_lb\_probe) | (Optional) Protocols to be used for lb health probes. Format as [protocol, port, request\_path] | `map(any)` | `{}` | no |
| <a name="input_lb_probe_interval"></a> [lb\_probe\_interval](#input\_lb\_probe\_interval) | Interval in seconds the load balancer health probe rule does a check | `number` | `5` | no |
| <a name="input_lb_probe_unhealthy_threshold"></a> [lb\_probe\_unhealthy\_threshold](#input\_lb\_probe\_unhealthy\_threshold) | Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy. | `number` | `2` | no |
| <a name="input_lb_sku"></a> [lb\_sku](#input\_lb\_sku) | (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard. | `string` | `"Basic"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Name of the load balancer. If it is set, the 'prefix' variable will be ignored. | `string` | `""` | no |
| <a name="input_pip_name"></a> [pip\_name](#input\_pip\_name) | (Optional) Name of public ip. If it is set, the 'prefix' variable will be ignored. | `string` | `""` | no |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | (Optional) The SKU of the Azure Public IP. Accepted values are Basic and Standard. | `string` | `"Basic"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) Default prefix to use with your resource names. | `string` | `"azure_lb"` | no |
| <a name="input_remote_port"></a> [remote\_port](#input\_remote\_port) | Protocols to be used for remote vm access. [protocol, backend\_port].  Frontend port will be automatically generated starting at 50000 and in the output. | `map(any)` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group where the load balancer resources will be imported. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "source": "terraform"<br>}</pre> | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) Defined if the loadbalancer is private or public | `string` | `"public"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_lb_backend_address_pool_id"></a> [azurerm\_lb\_backend\_address\_pool\_id](#output\_azurerm\_lb\_backend\_address\_pool\_id) | the id for the azurerm\_lb\_backend\_address\_pool resource |
| <a name="output_azurerm_lb_frontend_ip_configuration"></a> [azurerm\_lb\_frontend\_ip\_configuration](#output\_azurerm\_lb\_frontend\_ip\_configuration) | the frontend\_ip\_configuration for the azurerm\_lb resource |
| <a name="output_azurerm_lb_id"></a> [azurerm\_lb\_id](#output\_azurerm\_lb\_id) | the id for the azurerm\_lb resource |
| <a name="output_azurerm_lb_nat_rule_ids"></a> [azurerm\_lb\_nat\_rule\_ids](#output\_azurerm\_lb\_nat\_rule\_ids) | the ids for the azurerm\_lb\_nat\_rule resources |
| <a name="output_azurerm_lb_probe_ids"></a> [azurerm\_lb\_probe\_ids](#output\_azurerm\_lb\_probe\_ids) | the ids for the azurerm\_lb\_probe resources |
| <a name="output_azurerm_public_ip_address"></a> [azurerm\_public\_ip\_address](#output\_azurerm\_public\_ip\_address) | the ip address for the azurerm\_lb\_public\_ip resource |
| <a name="output_azurerm_public_ip_id"></a> [azurerm\_public\_ip\_id](#output\_azurerm\_public\_ip\_id) | the id for the azurerm\_lb\_public\_ip resource |
| <a name="output_azurerm_resource_group_name"></a> [azurerm\_resource\_group\_name](#output\_azurerm\_resource\_group\_name) | name of the resource group provisioned |
| <a name="output_azurerm_resource_group_tags"></a> [azurerm\_resource\_group\_tags](#output\_azurerm\_resource\_group\_tags) | the tags provided for the resource group |



## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.
