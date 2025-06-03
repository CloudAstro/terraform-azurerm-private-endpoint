# Azure Private Endpoint Terraform Module
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/cloudastro/private-endpoint/azurerm/)


This module is designed to manage Manages a Private Endpoint.

Azure Private Endpoint is a network interface that connects you privately and securely to a service powered by Azure Private Link. Private Endpoint uses a private IP address from your VNet, effectively bringing the service into your VNet. The service could be an Azure service such as Azure Storage, SQL, etc. or your own Private Link Service.

# Features

- **Private Connectivity:** Provides secure, private access to Azure services over a private IP address.
- **Azure Private Link Integration:** Connects to supported Azure PaaS services and custom services using Private Link.
- **DNS Configuration:** Supports automatic or manual DNS setup for private endpoint name resolution.
- **Network Security Integration:** Works with Network Security Groups (NSGs) and role-based access control (RBAC) for traffic and resource management.


# Example Usage
This example demonstrates how to use the `terraform-azurerm-private-endpoint` module to create a Private Endpoint and associate it to e private dns.
