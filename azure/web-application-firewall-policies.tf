
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy

resource "azurerm_web_application_firewall_policy" "web-application-firewall-policy" {
	name			= "${var.mutillidae-application-name}-web-application-firewall-policy"
	location            	= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	
	policy_settings{
		enabled				= "true"
		mode				= "Prevention"
		file_upload_limit_in_mb		= "100"
		request_body_check		= "true"
		max_request_body_size_in_kb	= "128"	
	}
	
	managed_rules {
		managed_rule_set {
			type	= "OWASP"
			version	= "3.2"	
		}
	}
}

