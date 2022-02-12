resource "azurerm_application_security_group" "bastion-hosts-application-security-group" {
	name			= "bastion-hosts-application-security-group"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	location		= "${azurerm_resource_group.resource-group.location}"
	tags			= "${var.default-tags}"
}

resource "azurerm_application_security_group" "application-servers-application-security-group" {
	name			= "application-servers-application-security-group"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	location		= "${azurerm_resource_group.resource-group.location}"
	tags			= "${var.default-tags}"
}
