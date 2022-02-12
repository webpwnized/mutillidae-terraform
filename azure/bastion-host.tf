locals {
	bastion-host-name			= "bastion-host"
	bastion-host-cloud-init-config-file	= "./cloud-init/bastion-host.yaml"
}

resource "azurerm_linux_virtual_machine" "bastion-host" {
	name                		= "${local.bastion-host-name}"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	tags				= "${var.default-tags}"
	computer_name			= "${local.bastion-host-name}"
	size				= "Standard_A2_v2"
	priority			= "Regular"
	provision_vm_agent		= true
	disable_password_authentication	= true
	encryption_at_host_enabled	= false	//Not supported for base level subscriptions
	secure_boot_enabled		= false //Not supported for Ubuntu 18.04-LTS image
	vtpm_enabled			= false //Not supported for Ubuntu 18.04-LTS image
	patch_mode			= "AutomaticByPlatform" 
	network_interface_ids		= [azurerm_network_interface.bastion-host-internal-network-interface-1.id]
	
	//user_data			= filebase64("${local.bastion-host-cloud-init-config-file}")
	
	source_image_reference {
		publisher = "Canonical"
		offer     = "UbuntuServer"
		sku       = "18.04-LTS"
		version   = "latest"
	}
	
	os_disk {
		name				= "${local.bastion-host-name}-os-disk"
		caching				= "ReadWrite"
		storage_account_type		= "Standard_LRS"
		write_accelerator_enabled	= false
	}
	
	admin_username		= "${var.ssh-username}"
	admin_ssh_key {
		username	= "${var.ssh-username}"
		public_key	= file("${var.ssh-public-key-file}")
	}
	
	additional_capabilities {
		ultra_ssd_enabled	= false
	}
}

output "bastion-host-principal_id" {
	value = flatten([
		for identity in azurerm_linux_virtual_machine.bastion-host[*].identity : identity[*].principal_id
	])
	description	= "The ID of the System Managed Service Principal"
}

output "bastion-host-tenant_id" {
	value = flatten([
		for identity in azurerm_linux_virtual_machine.bastion-host[*].identity : identity[*].tenant_id
	])
	description	= "The ID of the Tenant the System Managed Service Principal is assigned in"
}

output "bastion-host-private-ip-addresses" {
	value 		= "${jsonencode(azurerm_linux_virtual_machine.bastion-host.private_ip_addresses)}"
	description	= "A list of Private IP Addresses assigned to this Virtual Machine"
}

output "bastion-host-public-ip-addresses" {
	value 		= "${jsonencode(azurerm_linux_virtual_machine.bastion-host.public_ip_addresses)}"
	description	= "A list of Public IP Addresses assigned to this Virtual Machine"
}

