## 🌐 Additional Information  

For more information about Azure Private Endpoint and their configurations, refer to the [Azure Private Endpoint documentation](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview/). This module is designed to manage Manages a Private Endpoint.

## 📚 Resources

- [AzureRM Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [Azure Storage Overview](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)

## ⚠️ Notes

- Private Endpoints are created within a specific VNet. Services can be accessed privately from within the same VNet or peered VNets.
- Costs associated with Private Endpoints include charges for the private endpoint resource and any associated DNS zone usage. Regular data transfer costs still apply within Azure regions.
- Validate your Terraform configuration to ensure that all storage resources are created and configured correctly.

## 🧾 License  

This module is released under the **Apache 2.0 License**. See the [LICENSE](./LICENSE) file for full details.
