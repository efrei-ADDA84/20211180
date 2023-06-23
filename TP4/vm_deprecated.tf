#resource "azurerm_virtual_machine" "vm_tp4" {
#  name                  = "devops-20211180"
#  location              = var.location
#  resource_group_name   = var.resource_group
#  vm_size               = "Standard_D2s_v3"
#  network_interface_ids = [azurerm_network_interface.net_interface.id]
#
#  #delete the OS disk automatically when deleting the VM
#  delete_os_disk_on_termination = true
#
#  #delete the data disks automatically when deleting the VM
#  delete_data_disks_on_termination = true
#
#  storage_image_reference {
#    publisher = "Canonical"
#    offer     = "UbuntuServer"
#    sku       = "16.04-LTS"
#    version   = "latest"
#  }
#  storage_os_disk {
#    name              = "myosdisk1"
#    caching           = "ReadWrite"
#    create_option     = "FromImage"
#    managed_disk_type = "Standard_LRS"
#  }
#
#
#
#  os_profile {
#    computer_name                   = "devopsTP4"
#    admin_username                  = var.admin
#  }
#
#  os_profile_linux_config {
#    disable_password_authentication = true
#    ssh_keys {
#      key_data = tls_private_key.ssh.public_key_openssh
#      path = "/home/devops/.ssh/authorized_keys"
#    }
#  }
#
#  #admin_ssh_key {
#  #  username   = var.admin
#  #  public_key = tls_private_key.ssh.public_key_openssh
#  #}
#  
#  tags = {
#    environment = "staging"
#  }
#}