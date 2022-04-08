variable "tenant_id" {
  type = string
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}

variable "location" {
  type = string
  description = "Azure Location to deploy resources to. Default: uksouth"
  default = "uksouth"
}

variable "resource_group_name" {
  type = string
  description = "The name of the existing resource group in which to create the Key Vault."
}

variable "key_vault_name" {
  type = string
  description = "Name of the Azure Key Vault"
}

variable "sku_name" {
  type        = string
  description = "Select Standard or Premium SKU"
  default     = "standard"
}

variable "enabled_for_deployment" {
  type        = string
  description = "Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault"
  default     = "true"
}

variable "enabled_for_disk_encryption" {
  type        = string
  description = "Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys" 
  default     = "true"
}

variable "enabled_for_template_deployment" {
  type        = string
  description = "Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault"
  default     = "true"
}

variable "enable_rbac_authorization" {
    type        = string
    description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
    default     = "false"
}

variable "purge_protection_enabled" {
  type        = string
  description = "Prevents purging of values during their retention period"
  default     = "true"
}

variable "soft_delete_retention_days" {
  type        = string
  description = "Number of days to retain following deletion"
  default     = 7
}

variable "ip_rules" {
    type        = list(string)
    description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
    default     = []
}

variable "virtual_network_subnet_ids" {
    type        = list(string)
    description = "One or more Subnet ID's which should be able to access this Key Vault."
    default     = []
}

variable "tags" {
  type = map(string)
  description = "Map of Common Tags to be applied to all resources. Default: {}"
  default = {}
}

variable "policies" {
  type = map(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "Define a Azure Key Vault access policy"
  default = {}
}