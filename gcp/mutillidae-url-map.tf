
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_url_map

locals {
	mutillidae-url-map-project	= "${google_compute_network.gcp_vpc_network.project}"
	mutillidae-url-map-network	= "${google_compute_network.gcp_vpc_network.name}"
	mutillidae-url-map-name		= "${var.mutillidae-application-name}-url-map"
}

resource "google_compute_url_map" "mutillidae-url-map" {
	project		= "${local.mutillidae-url-map-project}"
	name		= "${local.mutillidae-url-map-name}"
	description	= "The ${var.mutillidae-application-name} URL map"
	default_service	= "${google_compute_backend_service.mutillidae-backend-service.id}"
}

