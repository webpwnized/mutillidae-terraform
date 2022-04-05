
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_url_map

locals {
	ldap-admin-url-map-project	= "${google_compute_network.gcp_vpc_network.project}"
	ldap-admin-url-map-network	= "${google_compute_network.gcp_vpc_network.name}"
	ldap-admin-url-map-name	= "${var.ldap-admin-application-name}-url-map"
}

resource "google_compute_url_map" "ldap-admin-url-map" {
	project		= "${local.ldap-admin-url-map-project}"
	name		= "${local.ldap-admin-url-map-name}"
	description	= "The ${var.ldap-admin-application-name} URL map"
	default_service	= "${google_compute_backend_service.ldap-admin-backend-service.id}"
}

