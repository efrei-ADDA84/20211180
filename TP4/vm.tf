resource "azurerm_linux_virtual_machine" "vm_tp4_20211180" {
  name                  = "devops-20211180"
  location              = var.location
  resource_group_name   = var.resource_group
  size                  = "Standard_D2s_v3"
  admin_username        = var.admin
  network_interface_ids = [azurerm_network_interface.net_interface.id]
  disable_password_authentication = true

  #delete the OS disk automatically when deleting the VM
  #delete_os_disk_on_termination = true

  #delete the data disks automatically when deleting the VM
  #delete_data_disks_on_termination = true

  admin_ssh_key {
    username = var.admin
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  connection {
    type     = "ssh"
    user     = var.admin
    host     = azurerm_public_ip.my_public_ip.ip_address
    private_key=tls_private_key.ssh.private_key_pem
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io"
    ]
  }
}