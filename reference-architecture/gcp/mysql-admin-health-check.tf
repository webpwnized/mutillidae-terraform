
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_http_health_check
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check

locals {
	mysql-admin-health-check-project	= "${google_compute_network.gcp_vpc_network.project}"
	mysql-admin-health-check-network	= "${google_compute_network.gcp_vpc_network.name}"
	mysql-admin-health-check-name		= "${var.mysql-admin-application-name}-health-check"
}

resource "google_compute_health_check" "mysql-admin-health-check" {
	project			= "${local.mysql-admin-backend-service-project}"
	name			= "${local.mysql-admin-health-check-name}"
	description 		= "The ${var.mysql-admin-application-name} Health Check"
	check_interval_sec	= 5
	timeout_sec		= 5
	healthy_threshold	= 2
	unhealthy_threshold	= 3
	
	tcp_health_check {
		port_name		= "mysql-admin-http-port"
		port_specification	= "USE_NAMED_PORT"
		proxy_header		= "NONE"
	}
	
	log_config {
		enable	= true
	}
}

output "mysql-admin-health-check-type" {
	value 		= "${google_compute_health_check.mysql-admin-health-check.type}"
	description	= "The type of health check"
}

