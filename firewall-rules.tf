
locals {
	firewall-project	= "${var.project}"
	firewall-region		= "${var.region}"
	firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
}

resource "google_compute_firewall" "fw-rule-allow-ssh-to-bastion-host-from-iap" {
	project		= "${local.firewall-project}"
	name		= "${local.firewall-network-name}-allow-ssh-to-bastion-host-from-iap"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow SSH to bastion host when using Identity Aware Proxy to tunnel traffic within the ${local.firewall-network-name} network"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["22"]
	}

	source_ranges	= ["35.235.240.0/20"]
	target_tags	= ["bastion-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}
