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
	mutillidae-gateway-private-ip-address	= "10.0.3.5"
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
		private_ip_address	= "${local.mutillidae-gateway-private-ip-address}"
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
