#######################################
# Module to create Keyvault Resource  #
#######################################


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
