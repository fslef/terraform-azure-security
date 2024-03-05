# resource "azurerm_security_center_contact" "example" {
#   count = var.mdfc-contact-email != null ? 1 : 0

#   name  = var.mdfc-contact-name
#   email = var.mdfc-contact-email
#   phone = var.mdfc-contact-phone

#   alert_notifications = var.mdfc-alert-by-email
#   alerts_to_admins    = var.mdfc-alert-to-admins

# }

variable "mdfc-alert-to-emails" {
  type    = string
  default = null
}

variable "mdfc-alert-to-phone" {
  type    = string
  default = null
}

variable "mdfc-alert-to-roles" {
  type    = list(string)
  default = []
  validation {
    condition     = alltrue([for val in var.mdfc-alert-to-roles : contains(["AccountAdmin", "Contributor", "Owner", "ServiceAdmin"], val)])
    error_message = "The role must be an array containing any of: 'AccountAdmin', 'Contributor', 'Owner', 'ServiceAdmin'."
  }
}

variable "mdfc-alert-minimal-severity" {
  type    = string
  default = "High"
  validation {
    condition     = contains(["High", "Low", "Medium"], var.mdfc-alert-minimal-severity)
    error_message = "Severity must be 'High', 'Low', or 'Medium'."
  }
}

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
