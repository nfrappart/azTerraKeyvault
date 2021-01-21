# Module description
This module will create a Key Vault in the current subscription. It will also grant the Service Principal used by terraform some permission in a KeyVault Access Policy

# Required resources
- Resource Group
- you'll also need to provide your Tenant ID

# Usage example

```hcl
module "Kv-DemoVault" {
  source = "github.com/nfrappart/azTerraKeyvault?ref=v1.0.1"
  KeyVaultName = "Kv-testvault"
  #KeyVaultLocation = "westeurope" #Optional. Default value is "westeurope"
  KeyVaultRgName = module.Rg_Demo.Name
  #KeyVaultSkuName = "standard" #Optional. Default value is "standard"
  KeyVaultTenantID = "YOUR-TENANT-ID" #Required! your tenant ID 
  #KeyVaultEnabledforDeployment = "true" #Optional. Default is set to "true"
  #KeyVaultEnabledforDiskEncrypt = "true" #Optional. Default is set to "true"
  #KeyVaultEnabledforTempDeploy = "true" #Optional. Default is set to "true"
  OwnerTag = "Nate" #Optional. But I suggest you change it though :)
  ProvisioningDateTag = timestamp() #This Tag is configured to NOT be updated unless resource is destroyed
  ProvisioningModeTag = "Terraform" 
}
```
