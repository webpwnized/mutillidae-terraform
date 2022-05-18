
locals {
	private-vpc-network-self-link	= "${google_compute_network.gcp_vpc_network.self_link}"
}

resource "google_compute_global_address" "private_ip_block" {
	provider	= google-beta
	name		= "private-ip-block"
	description	= "IP block to peer with Google network for private service connection"
	network		= "${local.private-vpc-network-self-link}"
	purpose		= "VPC_PEERING"
	address_type	= "INTERNAL"
	ip_version	= "IPV4"
	labels		= "${var.default-labels}"
	prefix_length	= "${var.database-subnet-prefix-length}"
	address		= "${var.database-subnet-network}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
	provider		= google-beta
	network			= "${local.private-vpc-network-self-link}"
	service			= "servicenetworking.googleapis.com"
	reserved_peering_ranges	= ["${google_compute_global_address.private_ip_block.name}"]
}

