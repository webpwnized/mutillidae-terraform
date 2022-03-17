
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule

locals {
	mysql-admin-forwarding-rule-project	= "${google_compute_network.gcp_vpc_network.project}"
	mysql-admin-forwarding-rule-network	= "${google_compute_network.gcp_vpc_network.name}"
	mysql-admin-forwarding-rule-name	= "${var.mysql-admin-application-name}-forwarding-rule"
}

resource "google_compute_global_forwarding_rule" "mysql-admin-forwarding-rule" {
	project			= "${local.mysql-admin-forwarding-rule-project}"
	name			= "${local.mysql-admin-forwarding-rule-name}"
	description		= "The ${var.mysql-admin-application-name} global forwarding rule"
	target			= "${google_compute_target_http_proxy.mysql-admin-target-http-proxy.id}"
	ip_protocol		= "TCP"
	load_balancing_scheme	= "EXTERNAL_MANAGED"
	port_range 		= "${var.http-port}"
}

output "mysql-admin-global-load-balancer-ip-address" {
	value = "${google_compute_global_forwarding_rule.mysql-admin-forwarding-rule.ip_address}"
}
