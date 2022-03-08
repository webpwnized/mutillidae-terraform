locals {
	mutillidae-gateway-ip-configuration	= "${var.mutillidae-application-name}-gateway-ip-configuration"
	mutillidae-frontend-port-name		= "${var.mutillidae-application-name}-frontend-port-name"
	mutillidae-public-frontend-ip-configuration-name		= "${var.mutillidae-application-name}-public-frontend-ip-address"
	mutillidae-private-frontend-ip-configuration-name 	= "${var.mutillidae-application-name}-private-frontend-ip-address"
	mutillidae-backend-address-pool-name	= "${var.mutillidae-application-name}-backend-address-pool-name"
	mutillidae-backend-http-setting-name	= "${var.mutillidae-application-name}-backend-http-setting-name"
	mutillidae-http-listener-name		= "${var.mutillidae-application-name}-http-listener-name"
	mutillidae-request-routing-rule-name	= "${var.mutillidae-application-name}-request-routing-rule-name"
	mutillidae-redirect-configuration-name	= "${var.mutillidae-application-name}-redirect-configuration-name"
}

resource "azurerm_application_gateway" "mutillidae-application-gateway" {
	name			= "mutillidae-application-gateway"
	location		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	fips_enabled		= false
	firewall_policy_id		= "${azurerm_web_application_firewall_policy.web-application-firewall-policy.id}"

	frontend_ip_configuration {
		name		= "${local.mutillidae-private-frontend-ip-configuration-name}"
		subnet_id	= "${azurerm_subnet.application-gateway-subnet.id}"
		private_ip_address	= "10.0.3.5"
		private_ip_address_allocation	= "Static"
	}

	frontend_ip_configuration {
		name			= "${local.mutillidae-public-frontend-ip-configuration-name}"
		public_ip_address_id	= "${azurerm_public_ip.mutillidae-application-public-ip.id}"
	}

	frontend_port {
		name	= "${local.mutillidae-frontend-port-name}"
		port	= "80"
	}
	
	backend_address_pool {
		name		= "${local.mutillidae-backend-address-pool-name}"
		ip_addresses	= ["${azurerm_linux_virtual_machine.docker-server.private_ip_address}"]
	}
	
	backend_http_settings {
		name			= "${local.mutillidae-backend-http-setting-name}"
		cookie_based_affinity	= "Disabled"
		path			= "/"
		port			= "${var.http-port}"
		protocol		= "Http"
		request_timeout		= 60
		connection_draining {
			enabled			= "true"
			drain_timeout_sec	= 60
		}
	}
	
	gateway_ip_configuration {
		name		= "${local.mutillidae-gateway-ip-configuration}"
		subnet_id	= "${azurerm_subnet.application-gateway-subnet.id}"
	}
	
	http_listener {
		name				= "${local.mutillidae-http-listener-name}"
		frontend_ip_configuration_name	= "${local.mutillidae-public-frontend-ip-configuration-name}"
		frontend_port_name		= "${local.mutillidae-frontend-port-name}"
		protocol			= "Http"
		require_sni			= false
	}
	
	request_routing_rule {
		name				= "${local.mutillidae-request-routing-rule-name}"
		rule_type			= "Basic"
		http_listener_name		= "${local.mutillidae-http-listener-name}"
		backend_address_pool_name	= "${local.mutillidae-backend-address-pool-name}"
		backend_http_settings_name	= "${local.mutillidae-backend-http-setting-name}"
	}

	sku {
		name		= "WAF_v2"
		tier		= "WAF_v2"
		capacity	= 1
	}
}

output "mutillidae-application-gateway-backend-address-pool" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.backend_address_pool)}"
	description	= "The backend_address_pool"
}

output "mutillidae-application-gateway-backend-http-settings" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.backend_http_settings)}"
	description	= "A list of backend_http_settings blocks"
}

output "mutillidae-application-gateway-frontend-ip-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.frontend_ip_configuration)}"
	description	= "A list of frontend_ip_configuration blocks"
}

output "mutillidae-application-gateway-frontend-port" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.frontend_port)}"
	description	= "A list of frontend_port blocks"
}

output "mutillidae-application-gateway-gateway-ip-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.gateway_ip_configuration)}"
	description	= "A list of gateway_ip_configuration blocks"
}

output "mutillidae-application-gateway-http-listener" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.http_listener)}"
	description	= "A list of http_listener blocks"
}

output "mutillidae-application-private-endpoint-connection" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.private_endpoint_connection)}"
	description	= "A list of private_endpoint_connection blocks"
}

output "mutillidae-application-private-link-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.private_link_configuration)}"
	description	= "A list of private_link_configuration blocks"
}

output "mutillidae-application-probe" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.probe)}"
	description	= "A list of probe blocks"
}

output "mutillidae-application-request-routing-rule" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.request_routing_rule)}"
	description	= "A list of request_routing_rule blocks"
}

output "mutillidae-application-url-path-map" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.url_path_map)}"
	description	= "A list of url_path_map blocks"
}

output "mutillidae-application-custom-error-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.custom_error_configuration)}"
	description	= "A list of custom_error_configuration blocks"
}

output "mutillidae-application-redirect-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mutillidae-application-gateway.redirect_configuration)}"
	description	= "A list of redirect_configuration blocks"
}

