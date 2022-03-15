
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule

locals {
	global-forwarding-rule-project	= "${google_compute_network.gcp_vpc_network.project}"
	global-forwarding-rule-network	= "${google_compute_network.gcp_vpc_network.name}"
	global-forwarding-rule-name	= "${var.mutillidae-application-name}-global-forwarding-rule"
}

resource "google_compute_global_forwarding_rule" "global-forwarding-rule" {
	project			= "${local.backend-service-project}"
	name			= "${local.global-forwarding-rule-name}"
	description		= "The global forwarding rule"
	target			= "${google_compute_target_http_proxy.target-http-proxy.id}"
	ip_protocol		= "TCP"
	ip_version		= "IPv4"
	load_balancing_scheme	= "EXTERNAL"
	port_range 		= "80"
}

