
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_backend_service

locals {
	ldap-admin-backend-service-project	= "${google_compute_network.gcp_vpc_network.project}"
	ldap-admin-backend-service-network	= "${google_compute_network.gcp_vpc_network.name}"
	ldap-admin-backend-service-name		= "${var.ldap-admin-application-name}-backend-service"
}

resource "google_compute_backend_service" "ldap-admin-backend-service" {
	project				= "${local.ldap-admin-backend-service-project}"
	name				= "${local.ldap-admin-backend-service-name}"
	description			= "The ${var.ldap-admin-application-name} backend service"
	timeout_sec			= 3
	connection_draining_timeout_sec	= 30
	enable_cdn			= false
	port_name			= "ldap-admin-http-port"
	protocol			= "HTTP"
	load_balancing_scheme		= "EXTERNAL_MANAGED"
	custom_response_headers		= ["Proxied-By: Google Cloud Load Balancer"]
	security_policy			= "${google_compute_security_policy.security-policy.id}"
	session_affinity		= "GENERATED_COOKIE"
	
	backend {
		group		= "${google_compute_instance_group.application-server-instance-group.id}"
		balancing_mode	= "UTILIZATION"
		max_utilization	= 0.80
	}
	
	health_checks	= ["${google_compute_health_check.ldap-admin-health-check.id}"]
	
	log_config {
		enable		= "true"
		sample_rate	= 1.0
	}
}


