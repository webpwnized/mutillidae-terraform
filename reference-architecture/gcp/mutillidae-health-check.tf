
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_http_health_check
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check

locals {
	mutillidae-health-check-project	= "${google_compute_network.gcp_vpc_network.project}"
	mutillidae-health-check-network	= "${google_compute_network.gcp_vpc_network.name}"
	mutillidae-health-check-name	= "${var.mutillidae-application-name}-health-check"
}

resource "google_compute_health_check" "mutillidae-health-check" {
	project			= "${local.mutillidae-backend-service-project}"
	name			= "${local.mutillidae-health-check-name}"
	description 		= "The ${var.mutillidae-application-name} Health Check"
	check_interval_sec	= 5
	timeout_sec		= 5
	healthy_threshold	= 2
	unhealthy_threshold	= 3
	
	tcp_health_check {
		port_name		= "mutillidae-http-port"
		port_specification	= "USE_NAMED_PORT"
		proxy_header		= "NONE"
	}
	
	log_config {
		enable	= true
	}
}

output "mutillidae-health-check-type" {
	value 		= "${google_compute_health_check.mutillidae-health-check.type}"
	description	= "The type of health check"
}

