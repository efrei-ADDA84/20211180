data "azurerm_virtual_network" "network-tp4" {
    name=var.network
    resource_group_name = var.resource_group
}
data "azurerm_subnet" "internal" {
  virtual_network_name = data.azurerm_virtual_network.network-tp4.name
  name                 = var.subnet
  resource_group_name  = var.resource_group

}
