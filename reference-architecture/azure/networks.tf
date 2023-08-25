
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "virtual-network" {
	name			= "${var.project-name}-virtual-network"
	resource_group_name	= "${azurerm_resource_group.resource-group.name}"
	address_space		= ["10.0.0.0/16"]
	location            	= "${azurerm_resource_group.resource-group.location}"
	tags			= "${var.default-tags}"
}

output "virtual-network-name" {
	value		= "${azurerm_virtual_network.virtual-network.name}"
	description	= "The name of the virtual network"
}

output "virtual-network-address-space" {
	value		= "${azurerm_virtual_network.virtual-network.address_space}"
	description	= "The list of address spaces used by the virtual network"
}

output "virtual-network-subnet" {
	value 		= [ for subnet in azurerm_virtual_network.virtual-network.subnet : tomap({"name" = subnet.name, "range"=subnet.address_prefix}) ]
	description	= "Subnet blocks"
}
