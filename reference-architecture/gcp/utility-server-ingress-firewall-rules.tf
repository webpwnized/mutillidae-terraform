locals {
	utility-server-firewall-project		= "${google_compute_network.gcp_vpc_network.project}"
	utility-server-firewall-region		= "${var.region}"
	utility-server-firewall-network-name	= "${google_compute_network.gcp_vpc_network.name}"
}

resource "google_compute_firewall" "allow-ssh-to-utility-server-from-bastion-host" {
	project		= "${local.utility-server-firewall-project}"
	name		= "allow-ssh-to-utility-server-from-bastion-host"
	network 	= "${local.utility-server-firewall-network-name}"
	description	= "Allow SSH to utility host from the bastion host in the ${local.utility-server-firewall-network-name} network"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= [var.ssh-port]
	}

	source_tags	= ["bastion-host"]
	target_tags	= ["utility-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

