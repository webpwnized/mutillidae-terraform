
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_backend_service

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
	
	backend {
		group                 = "${google_compute_instance_group.application-server-instance-group.id}"
		balancing_mode        = "RATE"
		max_rate_per_instance = 100
	}
	
	health_checks	= ["${google_compute_http_health_check.http-health-check.id}"]
}

