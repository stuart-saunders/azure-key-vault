output "id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.key_vault.id
}

output "name" {
  description = "Key Vault Name"
  value       = azurerm_key_vault.key_vault.name
}

output "vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "access_policy_ids" {
  description = "The Key Vault Access Policy Id"
  value       = azurerm_key_vault_access_policy.key_vault_access_policy[*]
}