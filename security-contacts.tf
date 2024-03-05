locals {
  notificationsByRole_state          = length(var.mdfc-alert-to-roles) > 0 || var.mdfc-alert-to-emails != null ? "On" : "Off"
  alertNotifications_state           = var.mdfc-alert-to-emails != null || length(var.mdfc-alert-to-roles) > 0 ? "On" : "Off"
  alertNotifications_minimalSeverity = var.mdfc-alert-minimal-severity

  contact_properties = {
    notificationsByRole = {
      state = local.notificationsByRole_state,
      roles = var.mdfc-alert-to-roles
    },
    emails = var.mdfc-alert-to-emails != null ? var.mdfc-alert-to-emails : "",
    phone  = var.mdfc-alert-to-phone != null ? var.mdfc-alert-to-phone : "",
    alertNotifications = {
      state           = local.alertNotifications_state,
      minimalSeverity = local.alertNotifications_minimalSeverity
    }
  }
}

resource "azapi_resource" "security_contact" {
  type = "Microsoft.Security/securityContacts@2020-01-01-preview"
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  name = "default"
  body = jsonencode({
    properties = local.contact_properties
  })
}
