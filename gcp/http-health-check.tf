
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_http_health_check

locals {
	http-health-check-project	= "${google_compute_network.gcp_vpc_network.project}"
	http-health-check-network	= "${google_compute_network.gcp_vpc_network.name}"
	http-health-check-name		= "${var.mutillidae-application-name}-http-health-check"
}

resource "google_compute_http_health_check" "http-health-check" {
	project				= "${local.backend-service-project}"
	name	= "${local.http-health-check-name}"
	description = "The HTTP Health Check"
	check_interval_sec	= 5
	timeout_sec		= 5
	healthy_threshold	= 2
	unhealthy_threshold	= 3
	port			= "${var.mutillidae-http-port}"
	request_path		= "/"
}

