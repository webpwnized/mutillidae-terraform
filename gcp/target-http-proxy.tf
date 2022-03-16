
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_target_http_proxy

locals {
	target-http-proxy-project	= "${google_compute_network.gcp_vpc_network.project}"
	target-http-proxy-network	= "${google_compute_network.gcp_vpc_network.name}"
	target-http-proxy-name		= "${var.mutillidae-application-name}-target-http-proxy"
}

resource "google_compute_target_http_proxy" "target-http-proxy" {
	project		= "${local.target-http-proxy-project}"
	name		= "${local.target-http-proxy-name}"
	description	= "The target HTTP proxy"
	url_map		= "${google_compute_url_map.url-map.id}"
}

