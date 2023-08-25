
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_security_group

resource "azurerm_network_security_group" "network-security-group" {
	name                	= "${var.project-name}-network-security-group"
	location            	= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
}

