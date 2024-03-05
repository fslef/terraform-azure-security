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

variable "mdfc-alert-by-email" {
  type        = bool
  default     = true
  description = "(Optional) Enable or disable alert notifications."
  nullable    = false
}

variable "mdfc-alert-to-admins" {
  type        = bool
  default     = true
  description = "(Optional) Enable or disable alerts to admins."
  nullable    = false
}

variable "mdfc-contact-email" {
  type        = string
  default     = null
}

variable "mdfc-contact-phone" {
  type        = string
  default     = null
}

variable "mdfc-contact-name" {
  type        = string
  default     = null
}