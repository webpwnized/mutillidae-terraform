
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_http_health_check
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check

locals {
	ldap-admin-health-check-project	= "${google_compute_network.gcp_vpc_network.project}"
	ldap-admin-health-check-network	= "${google_compute_network.gcp_vpc_network.name}"
	ldap-admin-health-check-name		= "${var.ldap-admin-application-name}-health-check"
}

resource "google_compute_health_check" "ldap-admin-health-check" {
	project			= "${local.ldap-admin-backend-service-project}"
	name			= "${local.ldap-admin-health-check-name}"
	description 		= "The ${var.ldap-admin-application-name} Health Check"
	check_interval_sec	= 10
	timeout_sec		= 10
	healthy_threshold	= 2
	unhealthy_threshold	= 3
	
	tcp_health_check {
		port_name		= "ldap-admin-http-port"
		port_specification	= "USE_NAMED_PORT"
		proxy_header		= "NONE"
	}
	
	log_config {
		enable	= true
	}
}

output "ldap-admin-health-check-type" {
	value 		= "${google_compute_health_check.ldap-admin-health-check.type}"
	description	= "The type of health check"
}

