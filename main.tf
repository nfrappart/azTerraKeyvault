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
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]

  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]

  certificate_permissions = [ 
    "Create",
    "Delete",
    "Get",
    "GetIssuers",
    "List",
    "ListIssuers",
    "Update",     
  ]
}