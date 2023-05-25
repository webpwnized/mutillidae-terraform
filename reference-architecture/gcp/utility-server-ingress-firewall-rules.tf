
resource "google_compute_firewall" "allow-ingress-ssh-iap-to-utility-server" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-ssh-iap-to-utility-server"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow SSH to utility host when using Identity Aware Proxy to tunnel traffic from the Internet"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "tcp"
		ports		= ["${var.ssh-port}"]
	}

	source_ranges	= var.gcp-iap-ip-address-range
	target_tags	= ["utility-server"]

	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}

resource "google_compute_firewall" "allow-icmp-to-utility-server-from-bastion-host" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-icmp-to-utility-server-from-bastion-host"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow PING to utility host from the bastion host"
	direction	= "INGRESS"
	disabled	= "false"
	priority	= 1000

	allow {
		protocol	= "icmp"
	}

	source_tags	= ["bastion-host"]
	target_tags	= ["utility-server"]
	
	log_config {
		metadata	= "INCLUDE_ALL_METADATA"
	}
}
