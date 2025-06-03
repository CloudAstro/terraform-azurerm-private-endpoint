resource "azurerm_role_assignment" "private_endpoint" {
  for_each = var.role_assignments != null ? var.role_assignments : {}

  principal_id                           = each.value.role_assignment.principal_id
  scope                                  = azurerm_private_endpoint.private_endpoint.id
  condition                              = each.value.role_assignment.condition
  condition_version                      = each.value.role_assignment.condition_version
  delegated_managed_identity_resource_id = each.value.role_assignment.delegated_managed_identity_resource_id
  principal_type                         = each.value.role_assignment.principal_type
  role_definition_id                     = each.value.role_assignment.role_definition_id_or_name
  role_definition_name                   = each.value.role_assignment.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.role_assignment.skip_service_principal_aad_check
}

resource "azurerm_application_security_group" "application_security_group" {
  for_each = var.application_security_group != null ? var.application_security_group : {}

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      read   = timeouts.value.read
      delete = timeouts.value.delete
    }
  }
}

resource "azurerm_private_endpoint_application_security_group_association" "application_security_group_accociation" {
  for_each = azurerm_application_security_group.application_security_group != null ? azurerm_application_security_group.application_security_group : {}

  application_security_group_id = each.value.id
  private_endpoint_id           = azurerm_private_endpoint.private_endpoint.id
}


resource "azurerm_management_lock" "this" {
  count = var.lock != null ? 1 : 0

  lock_level = var.lock.kind
  name       = coalesce(var.lock.name, "lock-${var.name}")
  scope      = azurerm_private_endpoint.private_endpoint.id
  notes      = var.lock.kind == "CanNotDelete" ? "Cannot delete the resource or its child resources." : "Cannot delete or modify the resource or its child resources."
}
