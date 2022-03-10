
locals {
	bastion-host-firewall-project		= "${google_compute_network.gcp_vpc_network.project}"
	bastion-host-firewall-region		= "${var.region}"
	bastion-host-firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
	bastion-host-firewall-rule-1-name	= "${local.bastion-host-firewall-network-name}-allow-ssh-to-bastion-host-from-iap"
	bastion-host-firewall-rule-1-description = "Allow SSH to bastion host when using Identity Aware Proxy to tunnel traffic within the ${local.bastion-host-firewall-network-name} network"
}

resource "google_compute_firewall" "allow-ssh-to-bastion-host-from-iap" {
	project		= "${local.bastion-host-firewall-project}"
	name		= "${local.bastion-host-firewall-rule-1-name}"
	network 	= "${local.bastion-host-firewall-network-name}"
	description	= "${local.bastion-host-firewall-rule-1-description}"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.ssh-port}"]
	}

	source_ranges	= var.gcp-iap-ip-address-range
	target_tags	= ["bastion-host"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}
