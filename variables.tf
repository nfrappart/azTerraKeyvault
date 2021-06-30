#Variable declaration for Module

variable "Name" {
  type = string
  description = "The name of the subscription"
}

variable "Location" {
  type    = string
  default = "francecentral"
}

variable "RgName" {
  type        = string
  description = "The name of the Resource group in which the Vault lives"
}

variable "SkuName" {
  type    = string
  default = "standard"
}

variable "TenantID" {
  type = string
  description = "The tenant Id of the vault"
}

variable "SoftDeleteRetention" {
  default = 7
}

variable "EnabledForDeployment" {
  type    = string
  default = "true"
}

variable "EnabledForDiskEncrypt" {
  type    = string
  default = "true"
}

variable "EnabledForTempDeploy" {
  type    = string
  default = "true"
}


# Variable to define the Tag

variable "EnvironmentTag" {
  type    = string
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = string
  default = "Poc usage only"
}

variable "OwnerTag" {
  type = string
  default = "DSI Covage"
}

variable "ProvisioningModeTag" {
  type = string
  default = "Terraform"
}
