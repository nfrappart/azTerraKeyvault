#######################################
# Module to create Keyvault Resource  #
#######################################

#Get current session informations
data "azurerm_client_config" "TerraClientConfig" {}

#KeyVault Creation
resource "azurerm_key_vault" "TerraKeyVault" {
  name                = var.Name
  location            = var.Location
  resource_group_name = var.RgName
  sku_name            = var.SkuName
  tenant_id           = var.TenantID
  soft_delete_retention_days  = var.SoftDeleteRetention
  purge_protection_enabled = var.purgeProtectionEnabled

  ########################
  #Others Keyvault param

  enabled_for_deployment          = var.EnabledForDeployment
  enabled_for_disk_encryption     = var.EnabledForDiskEncrypt
  enabled_for_template_deployment = var.EnabledForTempDeploy

  ########################
  #Tags
  tags = {
    Environment       = var.EnvironmentTag
    EnvironmentUsage  = var.EnvironmentUsageTag
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