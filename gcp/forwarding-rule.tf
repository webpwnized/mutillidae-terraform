
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule

locals {
	forwarding-rule-project	= "${google_compute_network.gcp_vpc_network.project}"
	forwarding-rule-network	= "${google_compute_network.gcp_vpc_network.name}"
	forwarding-rule-name	= "${var.mutillidae-application-name}-forwarding-rule"
}

resource "google_compute_global_forwarding_rule" "forwarding-rule" {
	project			= "${local.forwarding-rule-project}"
	name			= "${local.forwarding-rule-name}"
	description		= "The global forwarding rule"
	target			= "${google_compute_target_http_proxy.target-http-proxy.id}"
	ip_protocol		= "TCP"
	load_balancing_scheme	= "EXTERNAL_MANAGED"
	port_range 		= "80"
}

output "global-load-balancer-ip-address" {
	value = "${google_compute_global_forwarding_rule.forwarding-rule.ip_address}"
}
