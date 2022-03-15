
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule

locals {
	regional-forwarding-rule-project	= "${google_compute_network.gcp_vpc_network.project}"
	regional-forwarding-rule-network	= "${google_compute_network.gcp_vpc_network.name}"
	regional-forwarding-rule-name		= "${var.mutillidae-application-name}-regional-forwarding-rule"
}

resource "google_compute_forwarding_rule" "regional-forwarding-rule" {
	project			= "${local.backend-service-project}"
	region			= "${local.application-server-subnet-region}"
	name			= "${local.regional-forwarding-rule-name}"
	description		= "The global forwarding rule"
	target			= "${google_compute_target_http_proxy.target-http-proxy.id}"
	ip_protocol		= "TCP"
	load_balancing_scheme	= "EXTERNAL"
	network_tier		= "STANDARD"
	port_range 		= "80"
}

output "regional-load-balancer-ip-address" {
	value = "${google_compute_forwarding_rule.regional-forwarding-rule.ip_address}"
}
