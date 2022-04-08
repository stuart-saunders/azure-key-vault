# Azure Key Vault Terraform Module

Terraform module which creates an Azure Key Vault.

## Usage
```
resource "azurerm_resource_group" "kv_rg" {
  name     = var.resource_group_name
  location = var.location
}

module "key_vault" {
  source                   = "git::https://github.com/stuart-saunders/azure-key-vault.git?ref=1.0.0"
  key_vault_name           = var.kv_name
  location                 = azurerm_resource_group.kv_rg.location
  resource_group_name      = azurerm_resource_group.kv_rg.name

  purge_protection_enabled = false
  ip_rules                 = ["10.0.1.0", "10.0.1.1"]

  tags = {
    environment = locals.tags
  }

  policies = {
    full = {
      tenant_id               = var.azure_tenant_id
      object_id               = var.identity_object_id
      key_permissions         = var.kv_key_permissions_full
      secret_permissions      = var.kv_secret_permissions_full
      certificate_permissions = var.kv_certificate_permissions_full
      storage_permissions     = var.kv_storage_permissions_full
    }
  }
}
```
Note: Access to the vault is denied by default, and so either `ip_rules` or `virtual_network_subnet_ids` need to be provided.

Permissions can be defined with the following variables:-
```
variable "kv_secret_permissions_full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "kv_key_permissions_full" {
  type        = list(string)
  description = "List of full key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey"
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge",
  "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "kv_certificate_permissions_full" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
  "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore"]
}

variable "kv_storage_permissions_full" {
  type        = list(string)
  description = "List of full storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
  default = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas",
  "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
}

variable "kv_secret_permissions_read" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["get", "list"]
}

variable "kv_key_permissions_read" {
  type        = list(string)
  description = "List of read key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey"
  default     = ["get", "list"]
}

variable "kv_certificate_permissions_read" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default     = ["get", "getissuers", "list", "listissuers"]
}

variable "kv_storage_permissions_read" {
  type        = list(string)
  description = "List of read storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
  default     = ["get", "getsas", "list", "listsas"]
}
```

## Network ACLs
Access to the Key Vault should be restricted to certain IP addresses, CIDR ranges or subnets by supplying appropriate values for the`ip_rules` or `virtual_network_subnet_ids` keys in the `network_acls` block of the module's `azurerm_key_vault` resource.

These should be supplied to the module as lists of strings.