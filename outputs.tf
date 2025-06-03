output "private_endpoint" {
  value       = azurerm_private_endpoint.private_endpoint
  description = <<DESCRIPTION
  * `name` - Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created.
  * `resource_group_name` - Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.
  * `location` - The supported Azure location where the resource exists. Changing this forces a new resource to be created.
  * `subnet_id` - The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created.
  * `custom_network_interface_name` - The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.
  * `private_dns_zone_group` - A private_dns_zone_group block as defined below.
  * `private_service_connection` - (A private_service_connection block as defined below.
  * `ip_configuration` - One or more ip_configuration blocks as defined below. This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet.

  A `private_dns_zone_group` block exports:
  * `id` - The ID of the Private DNS Zone Group.
  * `name` - Specifies the Name of the Private DNS Zone Group.
  * `private_dns_zone_ids` - Specifies the list of Private DNS Zones to include within the `private_dns_zone_group`.

  A `private_service_connection` block exports:
  * `private_ip_address` - (Computed)The private IP address associated with the private endpoint, note that you will have a private IP address assigned to the private endpoint even if the connection request was Rejected.
  * `name` - Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
  * `is_manual_connection` - Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created.
  * `private_connection_resource_id` - The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created. For a web app or function app slot, the parent web app should be used in this field instead of a reference to the slot itself.
  * `private_connection_resource_alias` - The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created.
  * `subresource_names` - A list of subresource names which the Private Endpoint is able to connect to. `subresource_names` corresponds to `group_id`. Possible values are detailed in the product [documentation](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#private-link-resource) in the `Subresources` column. Changing this forces a new resource to be created.
  * `request_message` - A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. The provider allows a maximum request message length of `140` characters, however the request message maximum length is dependent on the service the private endpoint is connected to. Only valid if `is_manual_connection` is set to `true`.

  An `ip_configuration` block exports:
  * `name` - Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
  * `private_ip_address` - Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
  * `subresource_name` - Specifies the subresource this IP address applies to. `subresource_names` corresponds to `group_id`. Changing this forces a new resource to be created.
  * `member_name` - Specifies the member name this IP address applies to. If it is not specified, it will use the value of `subresource_name`. Changing this forces a new resource to be created.

Example output:
```
output "name" {
  value = module.module_name.private_endpoint.name
}
```
DESCRIPTION
}
