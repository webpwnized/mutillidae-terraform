
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_backend_service

locals {
	backend-service-project	= "${google_compute_network.gcp_vpc_network.project}"
	backend-service-network	= "${google_compute_network.gcp_vpc_network.name}"
	backend-service-name	= "${var.mutillidae-application-name}-backend-service"
}

resource "google_compute_backend_service" "backend-service" {
	project				= "${local.backend-service-project}"
	name				= "${local.backend-service-name}"
	description			= "The backend service"
	timeout_sec			= 3
	connection_draining_timeout_sec	= 30
	enable_cdn			= false
	port_name			= "mutillidae-http-port"
	protocol			= "HTTP"
	load_balancing_scheme		= "EXTERNAL"
	custom_response_headers		= ["Proxied-By: Google Load Balancer"]
	security_policy			= "${google_compute_security_policy.security-policy.id}"
	session_affinity		= "GENERATED_COOKIE"
	
	backend {
		group		= "${google_compute_instance_group.application-server-instance-group.id}"
		balancing_mode	= "UTILIZATION"
		max_utilization	= 0.80
	}
	
	health_checks	= ["${google_compute_health_check.http-health-check.id}"]
	
	log_config {
		enable		= "true"
		sample_rate	= 1.0
	}
}


