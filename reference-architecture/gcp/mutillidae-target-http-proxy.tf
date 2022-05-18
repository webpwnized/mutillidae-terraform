
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_target_http_proxy

locals {
	mutillidae-target-http-proxy-project	= "${google_compute_network.gcp_vpc_network.project}"
	mutillidae-target-http-proxy-network	= "${google_compute_network.gcp_vpc_network.name}"
	mutillidae-target-http-proxy-name	= "${var.mutillidae-application-name}-target-http-proxy"
}

resource "google_compute_target_http_proxy" "mutillidae-target-http-proxy" {
	project		= "${local.mutillidae-target-http-proxy-project}"
	name		= "${local.mutillidae-target-http-proxy-name}"
	description	= "The ${var.mutillidae-application-name} target HTTP proxy"
	url_map		= "${google_compute_url_map.mutillidae-url-map.id}"
}

