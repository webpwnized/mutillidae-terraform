locals {
	docker-server-name	= "docker-server"
}

resource "azurerm_linux_virtual_machine" "docker-server" {
	name                		= "${local.docker-server-name}"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	tags				= "${var.default-tags}"
	computer_name			= "${local.docker-server-name}"
	size				= "Standard_A2_v2"
	priority			= "Regular"
	provision_vm_agent		= true
	disable_password_authentication	= true
	encryption_at_host_enabled	= false	//Not supported for base level subscriptions
	secure_boot_enabled		= false //Not supported for Ubuntu 18.04-LTS image
	vtpm_enabled			= false //Not supported for Ubuntu 18.04-LTS image
	patch_mode			= "AutomaticByPlatform" 
	network_interface_ids		= [azurerm_network_interface.docker-server-internal-network-interface.id]
	
	user_data			= filebase64("../gcp/docker-server.cloud-init.yaml")
	
	source_image_reference {
		publisher = "Canonical"
		offer     = "UbuntuServer"
		sku       = "18.04-LTS"
		version   = "latest"
	}
	
	os_disk {
		name				= "${local.docker-server-name}-os-disk"
		caching				= "ReadWrite"
		storage_account_type		= "Standard_LRS"
		write_accelerator_enabled	= false
		//disk_size_gb			= "20"
	}
	
	admin_username		= "jeremy"
	admin_ssh_key {
		username	= "jeremy"
		public_key	= file("/home/jeremy/.ssh/azure-cloud-ssh-key.pub")
	}
	
	additional_capabilities {
		ultra_ssd_enabled	= false
	}
}

output "docker-server-principal_id" {
	value = flatten([
		for identity in azurerm_linux_virtual_machine.docker-server[*].identity : identity[*].principal_id
	])
	description	= "The ID of the System Managed Service Principal"
}

output "docker-server-tenant_id" {
	value = flatten([
		for identity in azurerm_linux_virtual_machine.docker-server[*].identity : identity[*].tenant_id
	])
	description	= "The ID of the Tenant the System Managed Service Principal is assigned in"
}

output "docker-server-private-ip-addresses" {
	value 		= "${jsonencode(azurerm_linux_virtual_machine.docker-server.private_ip_addresses)}"
	description	= "A list of Private IP Addresses assigned to this Virtual Machine"
}

output "docker-server-public-ip-addresses" {
	value 		= "${jsonencode(azurerm_linux_virtual_machine.docker-server.public_ip_addresses)}"
	description	= "A list of Public IP Addresses assigned to this Virtual Machine"
}

