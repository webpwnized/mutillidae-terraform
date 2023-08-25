
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "resource-group" {
	name     	= "${var.project-name}-resource-group"
	location 	= "${var.location}"
	tags		= "${var.default-tags}"
}
