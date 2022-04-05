locals {
	docker-server-name			= "docker-server"
	docker-server-cloud-init-config-file	= "./cloud-init/docker-server.yaml"
}

data "cloudinit_config" "docker-server-configuration" {
	gzip = false
	base64_encode = true

	part {
		content_type = "text/cloud-config"
		content = templatefile("${local.docker-server-cloud-init-config-file}",
			{
				username	= "${var.ssh-username}"
			}
		)
	}
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
	network_interface_ids		= [azurerm_network_interface.docker-server-network-interface-1.id]

	custom_data			= "${data.cloudinit_config.docker-server-configuration.rendered}"
	
	source_image_reference {
		publisher = "Canonical"
		offer     = "0001-com-ubuntu-server-focal"
		sku       = "20_04-lts"
		version   = "latest"
	}
	
	os_disk {
		name				= "${local.docker-server-name}-os-disk"
		caching				= "ReadWrite"
		storage_account_type		= "Standard_LRS"
		write_accelerator_enabled	= false
		//disk_size_gb			= "20"
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

output "docker-server-private-ip-addresses" {
	value 		= "${jsonencode(azurerm_linux_virtual_machine.docker-server.private_ip_addresses)}"
	description	= "A list of Private IP Addresses assigned to this Virtual Machine"
}

output "docker-server-public-ip-addresses" {
	value 		= "${jsonencode(azurerm_linux_virtual_machine.docker-server.public_ip_addresses)}"
	description	= "A list of Public IP Addresses assigned to this Virtual Machine"
}

