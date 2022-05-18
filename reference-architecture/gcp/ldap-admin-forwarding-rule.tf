
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule

locals {
	ldap-admin-forwarding-rule-project	= "${google_compute_network.gcp_vpc_network.project}"
	ldap-admin-forwarding-rule-network	= "${google_compute_network.gcp_vpc_network.name}"
	ldap-admin-forwarding-rule-name	= "${var.ldap-admin-application-name}-forwarding-rule"
}

resource "google_compute_global_forwarding_rule" "ldap-admin-forwarding-rule" {
	project			= "${local.ldap-admin-forwarding-rule-project}"
	name			= "${local.ldap-admin-forwarding-rule-name}"
	description		= "The ${var.ldap-admin-application-name} global forwarding rule"
	target			= "${google_compute_target_http_proxy.ldap-admin-target-http-proxy.id}"
	ip_protocol		= "TCP"
	load_balancing_scheme	= "EXTERNAL_MANAGED"
	port_range 		= "${var.http-port}"
}

output "ldap-admin-global-load-balancer-ip-address" {
	value = "${google_compute_global_forwarding_rule.ldap-admin-forwarding-rule.ip_address}"
}
