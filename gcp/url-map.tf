
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map

locals {
	url-map-project	= "${google_compute_network.gcp_vpc_network.project}"
	url-map-network	= "${google_compute_network.gcp_vpc_network.name}"
	url-map-name	= "${var.mutillidae-application-name}-url-map"
}

resource "google_compute_url_map" "url-map" {
	project		= "${local.backend-service-project}"
	name		= "${local.url-map-name}"
	description	= "The URL map"
	default_service	= "${google_compute_backend_service.backend-service.id}"
}

