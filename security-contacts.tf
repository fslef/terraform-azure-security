resource "azurerm_security_center_contact" "example" {
  count = var.mdfc-contact-email != null ? 1 : 0

  name  = var.mdfc-contact-name
  email = var.mdfc-contact-email
  phone = var.mdfc-contact-phone

  alert_notifications = var.mdfc-alert-by-email
  alerts_to_admins    = var.mdfc-alert-to-admins

  
}