output "plans_details" {
  description = "All plans details"
  value = {
    for name, pricing in azurerm_security_center_subscription_pricing.mdfc_plans : name => {
      id      = pricing.id
      subplan = pricing.subplan
    }
  }
}

output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = { for plan, pricing in azurerm_security_center_subscription_pricing.mdfc_plans : plan => pricing.id }
}