
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy

resource "azurerm_web_application_firewall_policy" "web-application-firewall-policy" {
	name			= "${var.mutillidae-application-name}-web-application-firewall-policy"
	location            	= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	managed_rules {
		managed_rule_set {
			type	= "OWASP"
			version	= "3.2"	
		}
	}
}

output "web-application-firewall-policy-id" {
	value		= "${azurerm_web_application_firewall_policy.web-application-firewall-policy.id}"
	description	= "The ID of the Web Application Firewall Policy"
}
