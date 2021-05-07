#######################################
# Module to create Keyvault Resource  #
#######################################

#Get current session informations
data "azurerm_client_config" "TerraClientConfig" {}

#KeyVault Creation

resource "azurerm_key_vault" "TerraKeyVault" {
  name                = var.KeyVaultName
  location            = var.KeyVaultLocation
  resource_group_name = var.KeyVaultRgName
  sku_name            = var.KeyVaultSkuName
  tenant_id           = var.KeyVaultTenantID
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  ########################
  #Others Keyvault param

  enabled_for_deployment          = var.KeyVaultEnabledforDeployment
  enabled_for_disk_encryption     = var.KeyVaultEnabledforDiskEncrypt
  enabled_for_template_deployment = var.KeyVaultEnabledforTempDeploy

  ########################
  #Tags
  tags = {
    Environment       = var.EnvironmentTag
    Usage             = var.UsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = timestamp()
    ProvisioningMode  = var.ProvisioningModeTag
  }

  lifecycle {
    ignore_changes = [
      tags["ProvisioningDate"],
    ]
  }
}

# add access to keyvault for terraform Service Principal
resource "azurerm_key_vault_access_policy" "TerraKeyVaultPolicyForTFSP" {
  key_vault_id = azurerm_key_vault.TerraKeyVault.id
  tenant_id    = data.azurerm_client_config.TerraClientConfig.tenant_id
  object_id    = data.azurerm_client_config.TerraClientConfig.object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set"
  ]

  certificate_permissions = [ 
    "create",
    "delete",
    "get",
    "getissuers",
    "list",
    "listissuers",
    "update",     
  ]
}