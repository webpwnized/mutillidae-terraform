
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_target_http_proxy

locals {
	ldap-admin-target-http-proxy-project	= "${google_compute_network.gcp_vpc_network.project}"
	ldap-admin-target-http-proxy-network	= "${google_compute_network.gcp_vpc_network.name}"
	ldap-admin-target-http-proxy-name	= "${var.ldap-admin-application-name}-target-http-proxy"
}

resource "google_compute_target_http_proxy" "ldap-admin-target-http-proxy" {
	project		= "${local.ldap-admin-target-http-proxy-project}"
	name		= "${local.ldap-admin-target-http-proxy-name}"
	description	= "The ${var.ldap-admin-application-name} target HTTP proxy"
	url_map		= "${google_compute_url_map.ldap-admin-url-map.id}"
}

