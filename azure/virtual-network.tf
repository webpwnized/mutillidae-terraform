resource "azurerm_virtual_network" "virtual-network" {
	name			= "${var.project-name}-virtual-network"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	address_space		= ["10.0.0.0/16"]
	location            	= "${azurerm_resource_group.resource-group.location}"
	tags			= "${var.default-tags}"

	subnet {
		name	= "iaas-subnet"
		address_prefix	= "10.0.0.0/28"
		security_group	= "${azurerm_network_security_group.network-security-group.id}"
	}
}
