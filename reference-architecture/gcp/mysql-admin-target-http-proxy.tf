
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_target_http_proxy

locals {
	mysql-admin-target-http-proxy-project	= "${google_compute_network.gcp_vpc_network.project}"
	mysql-admin-target-http-proxy-network	= "${google_compute_network.gcp_vpc_network.name}"
	mysql-admin-target-http-proxy-name	= "${var.mysql-admin-application-name}-target-http-proxy"
}

resource "google_compute_target_http_proxy" "mysql-admin-target-http-proxy" {
	project		= "${local.mysql-admin-target-http-proxy-project}"
	name		= "${local.mysql-admin-target-http-proxy-name}"
	description	= "The ${var.mysql-admin-application-name} target HTTP proxy"
	url_map		= "${google_compute_url_map.mysql-admin-url-map.id}"
}

