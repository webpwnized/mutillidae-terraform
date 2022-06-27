
resource "google_compute_firewall" "allow-ingress-ssh-iap-to-bastion-host" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	name		= "allow-ingress-ssh-iap-to-bastion-host"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	description	= "Allow SSH to bastion host when using Identity Aware Proxy to tunnel traffic from the Internet"
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
