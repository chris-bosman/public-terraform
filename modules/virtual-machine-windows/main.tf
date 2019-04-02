terraform {
    backend "azurerm" {}
}

data "azurerm_resource_group" "image" {
  name = "${var.image_resource_group}"
}
data "azurerm_image" "image" {
  name                = "${var.image_name}"
  resource_group_name = "${data.azurerm_resource_group.image.name}"
}

data "azurerm_key_vault" "vault" {
  name                = "pi-prd-kv"
  resource_group_name = "pi-vaults-rg"
}

data "azurerm_key_vault_secret" "vault" {
  name      = "vm-admin-creds"
  vault_uri = "${data.azurerm_key_vault.vault.vault_uri}"
}

# Resource Group
data "azurerm_resource_group" "deployment" {
  name  = "${var.resource_group_name}"
}

data "azurerm_virtual_network" "deployment" {
  name                = "${var.virtual_network_name}"
  resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

data "azurerm_subnet" "deployment" {
    name                  = "${var.subnet_name}"
    resource_group_name   = "${data.azurerm_resource_group.deployment.name}"
    virtual_network_name  = "${data.azurerm_virtual_network.deployment.name}"
}

# Public IP
data "azurerm_public_ip" "deployment" {
  name                = "${var.public_ip_name}"
  resource_group_name = "${data.azurerm_resource_group.deployment.name}"             
}

data "azurerm_network_interface" "deployment" {
  name                = "${var.network_interface_name}"
  resource_group_name = "${data.azurerm_resource_group.deployment.name}"
}

resource "azurerm_virtual_machine" "deployment" {
  name                  = "${var.virtual_machine_name}"
  location              = "${data.azurerm_resource_group.deployment.location}"
  resource_group_name   = "${data.azurerm_resource_group.deployment.name}"
  network_interface_ids = ["${data.azurerm_network_interface.deployment.id}"]
  vm_size               = "${var.virtual_machine_size}"

  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    id = "${data.azurerm_image.image.id}"
  }

  storage_os_disk {
    name              = "${var.vm_os_disk_name}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.vm_disk_replication_type}"
  }

  storage_data_disk {
    name              = "${var.vm_data_disk_name}1"
    managed_disk_type = "${var.vm_disk_replication_type}"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "${var.data_disk_size_in_gb}"
  }

  os_profile {
    computer_name  = "${var.virtual_machine_name}"
    admin_username = "pi-admin"
    admin_password = "${data.azurerm_key_vault_secret.vault.value}"
  }

  os_profile_windows_config {
  }

  tags {
    environment     = "${var.environment}"
    department      = "${var.department}"
    service         = "Compute"
    component       = "Virtual Machine"
    server_function = "${var.function_name}"
  }
}
