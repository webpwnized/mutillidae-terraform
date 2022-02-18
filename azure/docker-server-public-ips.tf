
resource "azurerm_public_ip" "mutillidae-application-public-ip" {
	name				= "mutillidae-application-public-ip"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	tags				= "${var.default-tags}"
	sku				= "Basic"
	sku_tier			= "Regional"
	allocation_method		= "Dynamic"	
	ip_version			= "IPv4"
	domain_name_label		= "${var.mutillidae-application-name}"
}

output "mutillidae-application-public-ip-address-id" {
	value 		= "${azurerm_public_ip.mutillidae-application-public-ip.id}"
	description	= "The Public IP ID"
}

output "mutillidae-application-public-ip-address" {
	value 		= "${azurerm_public_ip.mutillidae-application-public-ip.ip_address}"
	description	= "The IP address value that was allocated"
}

output "mutillidae-application-public-ip-address-fqdn" {
	value 		= "${azurerm_public_ip.mutillidae-application-public-ip.fqdn}"
	description	= "Fully qualified domain name of the A DNS record associated with the public IP"
}

resource "azurerm_public_ip" "mysql-admin-application-public-ip" {
	name				= "mysql-admin-application-public-ip"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	tags				= "${var.default-tags}"
	sku				= "Basic"
	sku_tier			= "Regional"
	allocation_method		= "Dynamic"	
	ip_version			= "IPv4"
	domain_name_label		= "${var.mysql-admin-application-name}"
}

output "mysql-admin-application-public-ip-address-id" {
	value 		= "${azurerm_public_ip.mysql-admin-application-public-ip.id}"
	description	= "The Public IP ID"
}

output "mysql-admin-application-public-ip-address" {
	value 		= "${azurerm_public_ip.mysql-admin-application-public-ip.ip_address}"
	description	= "The IP address value that was allocated"
}

output "mysql-admin-application-public-ip-address-fqdn" {
	value 		= "${azurerm_public_ip.mysql-admin-application-public-ip.fqdn}"
	description	= "Fully qualified domain name of the A DNS record associated with the public IP"
}

resource "azurerm_public_ip" "ldap-admin-application-public-ip" {
	name				= "ldap-admin-application-public-ip"
	location            		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 		= "${azurerm_resource_group.resource-group.name}"
	tags				= "${var.default-tags}"
	sku				= "Basic"
	sku_tier			= "Regional"
	allocation_method		= "Dynamic"	
	ip_version			= "IPv4"
	domain_name_label		= "${var.ldap-admin-application-name}"
}

output "ldap-admin-application-public-ip-address-id" {
	value 		= "${azurerm_public_ip.ldap-admin-application-public-ip.id}"
	description	= "The Public IP ID"
}

output "ldap-admin-application-public-ip-address" {
	value 		= "${azurerm_public_ip.ldap-admin-application-public-ip.ip_address}"
	description	= "The IP address value that was allocated"
}

output "ldap-admin-application-public-ip-address-fqdn" {
	value 		= "${azurerm_public_ip.ldap-admin-application-public-ip.fqdn}"
	description	= "Fully qualified domain name of the A DNS record associated with the public IP"
}

