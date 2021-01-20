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

  ########################
  #Others Keyvault param

  enabled_for_deployment          = var.KeyVaultEnabledforDeployment
  enabled_for_disk_encryption     = var.KeyVaultEnabledforDiskEncrypt
  enabled_for_template_deployment = var.KeyVaultEnabledforTempDeploy

  ########################
  #Tags
  tags = {
    Environment       = var.EnvironmentTag
    EnvironmentUsage  = var.EnvironmentUsageTag
    Owner             = var.OwnerTag
    ProvisioningDate  = var.ProvisioningDateTag
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
  tenant_id    = data.TerraClientConfig.current_azure_client_config.tenant_id
  object_id    = data.TerraClientConfig.current_azure_client_config.object_id

  key_permissions = [
    "get",
    "create",
    "delete",
    "list",
    "update",
  ]

  secret_permissions = [
    "get",
    "delete",
    "list",
    "set",
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