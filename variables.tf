variable "default_subplan" {
  type        = string
  default     = null
  description = "(Optional) Resource type pricing default subplan."
}

variable "default_tier" {
  type        = string
  default     = "Standard"
  description = "(Optional) The pricing tier to use. Possible values are `Free` and `Standard`"
  nullable    = false
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "(Optional) The location/region where the policy should exist."
}

variable "mdfc_databases_plans" {
  type = set(string)
  default = [
    "OpenSourceRelationalDatabases",
    "SqlServers",
    "SqlServerVirtualMachines",
    "CosmosDbs",
  ]
  description = "(Optional) Set of all mdfc databases plans"
  nullable    = false
}

variable "mdfc_plans_list" {
  type = set(string)
  default = [
    "AppServices",
    "Arm",
    "CloudPosture",
    "Containers",
    "KeyVaults",
    "OpenSourceRelationalDatabases",
    "SqlServers",
    "SqlServerVirtualMachines",
    "CosmosDbs",
    "StorageAccounts",
    "VirtualMachines",
    "Api",
  ]
  description = "(Optional) Set of all mdfc plans"
  nullable    = false
}

variable "mdfc_subplans" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`."
  nullable    = false
}

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

variable "sec_score_export_rg" {
  description = "The name of the resource group for secure score export"
  type        = string
  default     = null
}

variable "export_to_workspace_ID" {
  description = "The workspace ID for secure score export"
  type        = string
  default     = null
}