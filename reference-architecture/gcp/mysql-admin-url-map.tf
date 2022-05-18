
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_url_map

locals {
	mysql-admin-url-map-project	= "${google_compute_network.gcp_vpc_network.project}"
	mysql-admin-url-map-network	= "${google_compute_network.gcp_vpc_network.name}"
	mysql-admin-url-map-name	= "${var.mysql-admin-application-name}-url-map"
}

resource "google_compute_url_map" "mysql-admin-url-map" {
	project		= "${local.mysql-admin-url-map-project}"
	name		= "${local.mysql-admin-url-map-name}"
	description	= "The ${var.mysql-admin-application-name} URL map"
	default_service	= "${google_compute_backend_service.mysql-admin-backend-service.id}"
}

