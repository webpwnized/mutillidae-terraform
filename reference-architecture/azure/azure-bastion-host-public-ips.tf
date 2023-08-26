
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "azure-bastion-host-public-ip" {
	name				= "azure-bastion-host-public-ip"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	tags				= "${var.default-tags}"
	sku				= "Standard"
	sku_tier			= "Regional"
	allocation_method		= "Static"	
	ip_version			= "IPv4"
	domain_name_label		= "${var.azure-bastion-host-name}"
}

output "azure-bastion-host-public-ip-address" {
	value 		= "${azurerm_public_ip.azure-bastion-host-public-ip.ip_address}"
	description	= "The IP address value that was allocated"
}

output "azure-bastion-host-public-ip-address-fqdn" {
	value 		= "${azurerm_public_ip.azure-bastion-host-public-ip.fqdn}"
	description	= "Fully qualified domain name of the A DNS record associated with the public IP"
}

