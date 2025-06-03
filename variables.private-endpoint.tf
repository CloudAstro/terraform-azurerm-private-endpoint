variable "name" {
  type        = string
  description = <<DESCRIPTION
  * `name` - (Required) Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created.

  Example Input:
  ```
  name = "blob-private-endpoint"
  ```
  DESCRIPTION
}

variable "resource_group_name" {
  type        = string
  description = <<DESCRIPTION
  * `resource_group_name` - (Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created.

  Example Input:
  ```
  resource_group_name = "my-resource-group"
  ```
  DESCRIPTION
}

variable "location" {
  type        = string
  description = <<DESCRIPTION
  * `location` - (Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created.

  Example Input:
  ```
  location = "East US"
  ```
  DESCRIPTION
}

variable "subnet_id" {
  type        = string
  description = <<DESCRIPTION
  * `subnet_id` - (Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created.

  Example Input:
  ```
  subnet_id = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>"
  ```
  DESCRIPTION
}

variable "custom_network_interface_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
  * `custom_network_interface_name` - (Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created.

  Example Input:
  ```
  custom_network_interface_name = "my-custom-nic"
  ```
  DESCRIPTION
}

variable "private_dns_zone_group" {
  type = map(object({
    name                 = string
    private_dns_zone_ids = set(string)
  }))
  default     = null
  description = <<DESCRIPTION
  * `private_dns_zone_group` -(Optional) Specify private dns zone group for private endpoint
    A `private_dns_zone_group` block supports the following:
    * `name` - (Required) Specifies the Name of the Private DNS Zone Group.
    * `private_dns_zone_ids` - (Required) Specifies the list of Private DNS Zones to include within the `private_dns_zone_group`.

  Example Input:
  ```
  private_dns_zone_group = {
    "group1" = {
      name = "example-dns-zone-group"
      private_dns_zone_ids = [
        "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
      ]
    }
  }
  ```
  DESCRIPTION
}

variable "private_service_connection" {
  type = object({
    name                              = string
    is_manual_connection              = bool
    private_connection_resource_id    = optional(string)
    private_connection_resource_alias = optional(string)
    subresource_names                 = optional(set(string))
    request_message                   = optional(string)
  })
  description = <<DESCRIPTION
  * `private_service_connection` - (Required) Specify service connection for private endpoint
  A `private_service_connection` block supports the following:
    * `name` - (Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
    * `is_manual_connection` - (Required) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created.
    -> **NOTE:** If you are trying to connect the Private Endpoint to a remote resource without having the correct RBAC permissions on the remote resource set this value to `true`.
    * `private_connection_resource_id` - (Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created. For a web app or function app slot, the parent web app should be used in this field instead of a reference to the slot itself.
    * `private_connection_resource_alias` - (Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created.
    * `subresource_names` - (Optional) A list of subresource names which the Private Endpoint is able to connect to. `subresource_names` corresponds to `group_id`. Possible values are detailed in the product [documentation](https://docs.microsoft.com/azure/private-link/private-endpoint-overview#private-link-resource) in the `Subresources` column. Changing this forces a new resource to be created.
    -> **NOTE:** Some resource types (such as Storage Account) only support 1 subresource per private endpoint.
    -> **NOTE:** For most Private Links one or more `subresource_names` will need to be specified, please see the linked documentation for details.
    * `request_message` - (Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. The provider allows a maximum request message length of `140` characters, however the request message maximum length is dependent on the service the private endpoint is connected to. Only valid if `is_manual_connection` is set to `true`.
    -> **NOTE:** When connected to an SQL resource the `request_message` maximum length is `128`.

  Example Input:
  ```
  private_service_connection = {
    name                           = "connection1"  # Example value
    private_connection_resource_id = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.KeyVault/vaults/<keyvault-name>"
    is_manual_connection           = false  # Example value
    subresource_names              = ["blob"]  # Example value
    request_message                = "Please approve this connection."
  }
  ```
  DESCRIPTION
}

variable "ip_configurations" {
  type = map(object({
    name               = string
    private_ip_address = string
    subresource_name   = optional(string)
    member_name        = optional(string)
  }))
  default     = null
  description = <<DESCRIPTION
  * `ip_configurations` - (Optional) Specify ip configurations for private endpoint
  An `ip_configuration` block supports the following:
    * `name` - (Required) Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
    * `private_ip_address` - (Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
    * `subresource_name` - (Optional) Specifies the subresource this IP address applies to. `subresource_names` corresponds to `group_id`. Changing this forces a new resource to be created.
    * `member_name` - (Optional) Specifies the member name this IP address applies to. If it is not specified, it will use the value of `subresource_name`. Changing this forces a new resource to be created.
    -> **NOTE:** `member_name` will be required and will not take the value of `subresource_name` in the next major version.
  Example Input:
  ```
  ip_configurations = {
    ipconfig1= {
      name               = "ipconfig1"  # Example value
      member_name        = "member1"  # Example value
      subresource_name   = "blob"  # Example value
      private_ip_address = "10.0.0.4"  # Example value
    }
  }
  ```
  DESCRIPTION
}

variable "timeouts" {
  type = object({
    create = optional(string, "60")
    update = optional(string, "60")
    read   = optional(string, "5")
    delete = optional(string, "60")
  })
  default     = null
  description = <<DESCRIPTION
The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:
  * `create` - (Defaults to 60 minutes) Used when creating the Subnet.
  * `update` - (Defaults to 60 minutes) Used when updating the Subnet.
  * `read` - (Defaults to 5 minutes) Used when retrieving the Subnet.
  * `delete` - (Defaults to 60 minutes) Used when deleting the Subnet.
DESCRIPTION
}
