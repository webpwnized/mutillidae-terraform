locals {
	mysql-admin-gateway-ip-configuration	= "${var.mysql-admin-application-name}-gateway-ip-configuration"
	mysql-admin-frontend-port-name		= "${var.mysql-admin-application-name}-frontend-port-name"
	mysql-admin-public-frontend-ip-configuration-name		= "${var.mysql-admin-application-name}-public-frontend-ip-address"
	mysql-admin-private-frontend-ip-configuration-name 	= "${var.mysql-admin-application-name}-private-frontend-ip-address"
	mysql-admin-backend-address-pool-name	= "${var.mysql-admin-application-name}-backend-address-pool-name"
	mysql-admin-backend-http-setting-name	= "${var.mysql-admin-application-name}-backend-http-setting-name"
	mysql-admin-http-listener-name		= "${var.mysql-admin-application-name}-http-listener-name"
	mysql-admin-request-routing-rule-name	= "${var.mysql-admin-application-name}-request-routing-rule-name"
	mysql-admin-redirect-configuration-name	= "${var.mysql-admin-application-name}-redirect-configuration-name"
}

resource "azurerm_application_gateway" "mysql-admin-application-gateway" {
	name			= "mysql-admin-application-gateway"
	location		= "${azurerm_resource_group.resource-group.location}"
	resource_group_name 	= "${azurerm_resource_group.resource-group.name}"
	tags			= "${var.default-tags}"
	fips_enabled		= false
	firewall_policy_id		= "${azurerm_web_application_firewall_policy.web-application-firewall-policy.id}"

	frontend_ip_configuration {
		name		= "${local.mysql-admin-private-frontend-ip-configuration-name}"
		subnet_id	= "${azurerm_subnet.application-gateway-subnet.id}"
		private_ip_address	= "10.0.3.6"
		private_ip_address_allocation	= "Static"
	}

	frontend_ip_configuration {
		name			= "${local.mysql-admin-public-frontend-ip-configuration-name}"
		public_ip_address_id	= "${azurerm_public_ip.mysql-admin-application-public-ip.id}"
	}

	frontend_port {
		name	= "${local.mysql-admin-frontend-port-name}"
		port	= "80"
	}
	
	backend_address_pool {
		name		= "${local.mysql-admin-backend-address-pool-name}"
		ip_addresses	= ["${azurerm_linux_virtual_machine.docker-server.private_ip_address}"]
	}
	
	backend_http_settings {
		name			= "${local.mysql-admin-backend-http-setting-name}"
		cookie_based_affinity	= "Disabled"
		path			= "/"
		port			= "${var.mysql-admin-http-port}"
		protocol		= "Http"
		request_timeout		= 60
		connection_draining {
			enabled			= "true"
			drain_timeout_sec	= 60
		}
	}
	
	gateway_ip_configuration {
		name		= "${local.mysql-admin-gateway-ip-configuration}"
		subnet_id	= "${azurerm_subnet.application-gateway-subnet.id}"
	}
	
	http_listener {
		name				= "${local.mysql-admin-http-listener-name}"
		frontend_ip_configuration_name	= "${local.mysql-admin-public-frontend-ip-configuration-name}"
		frontend_port_name		= "${local.mysql-admin-frontend-port-name}"
		protocol			= "Http"
		require_sni			= false
	}
	
	request_routing_rule {
		name				= "${local.mysql-admin-request-routing-rule-name}"
		rule_type			= "Basic"
		http_listener_name		= "${local.mysql-admin-http-listener-name}"
		backend_address_pool_name	= "${local.mysql-admin-backend-address-pool-name}"
		backend_http_settings_name	= "${local.mysql-admin-backend-http-setting-name}"
	}

	sku {
		name		= "WAF_v2"
		tier		= "WAF_v2"
		capacity	= 1
	}
}

output "mysql-admin-application-gateway-backend-address-pool" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.backend_address_pool)}"
	description	= "The backend_address_pool"
}

output "mysql-admin-application-gateway-backend-http-settings" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.backend_http_settings)}"
	description	= "A list of backend_http_settings blocks"
}

output "mysql-admin-application-gateway-frontend-ip-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.frontend_ip_configuration)}"
	description	= "A list of frontend_ip_configuration blocks"
}

output "mysql-admin-application-gateway-frontend-port" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.frontend_port)}"
	description	= "A list of frontend_port blocks"
}

output "mysql-admin-application-gateway-gateway-ip-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.gateway_ip_configuration)}"
	description	= "A list of gateway_ip_configuration blocks"
}

output "mysql-admin-application-gateway-http-listener" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.http_listener)}"
	description	= "A list of http_listener blocks"
}

output "mysql-admin-application-private-endpoint-connection" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.private_endpoint_connection)}"
	description	= "A list of private_endpoint_connection blocks"
}

output "mysql-admin-application-private-link-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.private_link_configuration)}"
	description	= "A list of private_link_configuration blocks"
}

output "mysql-admin-application-probe" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.probe)}"
	description	= "A list of probe blocks"
}

output "mysql-admin-application-request-routing-rule" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.request_routing_rule)}"
	description	= "A list of request_routing_rule blocks"
}

output "mysql-admin-application-url-path-map" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.url_path_map)}"
	description	= "A list of url_path_map blocks"
}

output "mysql-admin-application-custom-error-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.custom_error_configuration)}"
	description	= "A list of custom_error_configuration blocks"
}

output "mysql-admin-application-redirect-configuration" {
	value 		= "${jsonencode(azurerm_application_gateway.mysql-admin-application-gateway.redirect_configuration)}"
	description	= "A list of redirect_configuration blocks"
}

