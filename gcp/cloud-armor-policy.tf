
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy

locals {
	security-policy-project	= "${google_compute_network.gcp_vpc_network.project}"
	security-policy-name		= "${google_compute_network.gcp_vpc_network.name}-security-policy"
	security-policy-description	= "Cloud Armor security policy"
}

resource "google_compute_security_policy" "security-policy" {
	project		= "${local.security-policy-project}"
	name		= "${local.security-policy-name}"
	description	= "${local.security-policy-description}"
}
