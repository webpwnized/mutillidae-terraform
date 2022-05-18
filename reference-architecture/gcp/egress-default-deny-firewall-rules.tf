
locals {
	egress-firewall-project		= "${google_compute_network.gcp_vpc_network.project}"
	egress-firewall-region		= "${var.region}"
	egress-firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
}

resource "google_compute_firewall" "deny-all-egress" {
	project		= "${local.egress-firewall-project}"
	name		= "${local.egress-firewall-network-name}-deny-all-egress"
	network 	= "${local.egress-firewall-network-name}"
	description	= "Deny all egress traffic leaving the ${local.egress-firewall-network-name} network"
	direction	= "EGRESS"
	disabled	= "false"
	priority	= 65533

	deny {
		protocol	= "all"
	}

	destination_ranges	= ["0.0.0.0/0"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}





