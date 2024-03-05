locals {
  final_plans_list        = contains(var.mdfc_plans_list, "CloudPosture") ? setsubtract(setunion(local.plans_without_databases), ["CloudPosture"]) : local.plans_without_databases
  plans_without_databases = contains(var.mdfc_plans_list, "Databases") ? setsubtract(setunion(var.mdfc_plans_list, var.mdfc_databases_plans), ["Databases"]) : var.mdfc_plans_list
}

data "azurerm_subscription" "current" {}

resource "azurerm_security_center_subscription_pricing" "mdfc_plans" {
  for_each      = local.final_plans_list
  tier          = var.default_tier
  resource_type = each.value
  # For "StorageAccounts" subplan is "PerStorageAccount". For other plans subplan is null.
  subplan = lookup(var.mdfc_subplans, each.key, each.key == "StorageAccounts" ? "PerStorageAccount" : var.default_subplan)

  dynamic "extension" {
    for_each = each.key == "VirtualMachines" ? [1] : []
    content {
      name = "AgentlessVmScanning"
      additional_extension_properties = {
        ExclusionTags = "[]"
      }
    }
  }
}

# Todo: Issue #105 Add workspace coverage for security module
