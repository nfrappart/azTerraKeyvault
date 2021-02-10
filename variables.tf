#Variable declaration for Module

variable "KeyVaultName" {
  type = string
  description = "The name of the subscription"
}

variable "KeyVaultLocation" {
  type    = string
  default = "westeurope"
}

variable "KeyVaultRgName" {
  type        = string
  description = "The name of the Resource group in which the Vault lives"
}

variable "KeyVaultSkuName" {
  type    = string
  default = "standard"
}

variable "KeyVaultTenantID" {
  type = string
  description = "The tenant Id of the vault"
}

variable "KeyVaultEnabledforDeployment" {
  type    = string
  default = "true"
}

variable "KeyVaultEnabledforDiskEncrypt" {
  type    = string
  default = "true"
}

variable "KeyVaultEnabledforTempDeploy" {
  type    = string
  default = "true"
}

# Variable to define the Tag

variable "EnvironmentTag" {
  type    = string
  default = "Test"
}
variable "UsageTag" {
  type = string
  default = "PoC usage only"
}

variable "OwnerTag" {
  type = string
  default = "Nate"
}

variable "ProvisioningModeTag" {
  type = string
  default = "Terraform"
}
