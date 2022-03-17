
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule

locals {
	mutillidae-forwarding-rule-project	= "${google_compute_network.gcp_vpc_network.project}"
	mutillidae-forwarding-rule-network	= "${google_compute_network.gcp_vpc_network.name}"
	mutillidae-forwarding-rule-name	= "${var.mutillidae-application-name}-forwarding-rule"
}

resource "google_compute_global_forwarding_rule" "mutillidae-forwarding-rule" {
	project			= "${local.mutillidae-forwarding-rule-project}"
	name			= "${local.mutillidae-forwarding-rule-name}"
	description		= "The ${var.mutillidae-application-name} global forwarding rule"
	target			= "${google_compute_target_http_proxy.mutillidae-target-http-proxy.id}"
	ip_protocol		= "TCP"
	load_balancing_scheme	= "EXTERNAL_MANAGED"
	port_range 		= "80"
}

output "mutillidae-global-load-balancer-ip-address" {
	value = "${google_compute_global_forwarding_rule.mutillidae-forwarding-rule.ip_address}"
}
