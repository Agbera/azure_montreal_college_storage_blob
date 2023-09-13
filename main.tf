#This is an Azure Montreal College Tutorial for Storage Account creation--->Storage Container name Creation--->Storage Blob Creation
resource "azurerm_resource_group" "azureresourcegroup" {
  name     = "MCIT_resource_group"
  location = "Canada Central"
}
resource "azurerm_storage_account" "azurermstorageaccount" {
  name                     = "MCIT-azurerm_strg_acc"
  resource_group_name      = azurerm_resource_group.MCIT_resource_group
  location                 = azurerm_resource_group.canada.central
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "azurermcontainer" {
  name                  = "MCIT_azrm_container"
  storage_account_name  = azurerm_storage_account.MCIT-azurerm_strg_acc
  container_access_type = "private"
}
