resource "azurerm_firewall_policy" "mutillidae-application-firewall-policy" {
	name			= "${var.mutillidae-application-name}-firewall-policy"
	location            	= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	sku			= "Standard"
}

output "mutillidae-firewall-policy-firewalls" {
	value		= "${azurerm_firewall_policy.mutillidae-application-firewall-policy.firewalls}"
	description	= "A list of references to Azure Firewalls that this Firewall Policy is associated with"
}

resource "azurerm_firewall_policy" "mysql-admin-application-firewall-policy" {
	name			= "${var.mysql-admin-application-name}-firewall-policy"
	location            	= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	sku			= "Standard"
}

output "mysql-admin-application-firewall-policy-firewalls" {
	value		= "${azurerm_firewall_policy.mysql-admin-application-firewall-policy.firewalls}"
	description	= "A list of references to Azure Firewalls that this Firewall Policy is associated with"
}

resource "azurerm_firewall_policy" "ldap-admin-application-firewall-policy" {
	name			= "${var.ldap-admin-application-name}-firewall-policy"
	location            	= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	sku			= "Standard"
}

output "ldap-admin-application-firewall-policy-firewalls" {
	value		= "${azurerm_firewall_policy.ldap-admin-application-firewall-policy.firewalls}"
	description	= "A list of references to Azure Firewalls that this Firewall Policy is associated with"
}

