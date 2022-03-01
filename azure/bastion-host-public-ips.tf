
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "bastion-host-public-ip" {
	name				= "bastion-host-public-ip"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	tags				= "${var.default-tags}"
	sku				= "Basic"
	sku_tier			= "Regional"
	allocation_method		= "Dynamic"	
	ip_version			= "IPv4"
	domain_name_label		= "${local.bastion-host-name}-ext"
}

output "bastion-host-public-ip-address" {
	value 		= "${azurerm_public_ip.bastion-host-public-ip.ip_address}"
	description	= "The IP address value that was allocated"
}

output "bastion-host-public-ip-address-fqdn" {
	value 		= "${azurerm_public_ip.bastion-host-public-ip.fqdn}"
	description	= "Fully qualified domain name of the A DNS record associated with the public IP"
}

