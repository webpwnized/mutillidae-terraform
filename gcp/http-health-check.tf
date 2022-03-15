
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_http_health_check

locals {
	http-health-check-project	= "${google_compute_network.gcp_vpc_network.project}"
	http-health-check-network	= "${google_compute_network.gcp_vpc_network.name}"
	http-health-check-name		= "${var.mutillidae-application-name}-http-health-check"
}

resource "google_compute_region_health_check" "http-region-health-check" {
	project			= "${local.backend-service-project}"
	region			= "${local.application-server-subnet-region}"
	name			= "${local.http-health-check-name}"
	description 		= "The Regional HTTP Health Check"
	check_interval_sec	= 5
	timeout_sec		= 5
	healthy_threshold	= 2
	unhealthy_threshold	= 3
	
	http_health_check {
		request_path		= "/"	
		port			= "${var.mutillidae-http-port}"
		proxy_header		= "NONE"
		port_specification	= "USE_FIXED_PORT"
	}
	
	log_config {
		enable	= true
	}
}

output "http-region-health-check-type" {
	value 		= "${google_compute_region_health_check.http-region-health-check.type}"
	description	= "The type of the health check"
}

