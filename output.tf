#Module Output

output "Id" {
  value = azurerm_key_vault.TerraKeyVault.id
}

output "Name" {
  value = azurerm_key_vault.TerraKeyVault.name
}

output "URI" {
  value = azurerm_key_vault.TerraKeyVault.vault_uri
}

output "KeyVault_enabled_for_disk_encryption" {
  value = azurerm_key_vault.TerraKeyVault.enabled_for_disk_encryption
}

output "KeyVault_enabled_for_template_deployment" {
  value = azurerm_key_vault.TerraKeyVault.enabled_for_template_deployment
}

output "KeyVault_location" {
  value = azurerm_key_vault.TerraKeyVault.location
}
