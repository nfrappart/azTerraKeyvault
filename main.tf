#######################################
# Module to create Keyvault Resource  #
#######################################


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
