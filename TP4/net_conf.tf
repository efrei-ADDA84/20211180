# Create public IPs
resource "azurerm_public_ip" "my_public_ip" {
  name                = "20211180"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}

# Create the network interface
# Here, we are using existing network and subnet
resource "azurerm_network_interface" "net_interface" {
  name                = "20211180"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "20211180-v2"
    subnet_id                     = data.azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_public_ip.id
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
