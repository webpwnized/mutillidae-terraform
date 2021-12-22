locals {
	network-project		= "${var.project}"
	network-name		= "mutillidae-vpc-t"
}

resource "google_compute_network" "gcp_vpc_network" {
	project			= "${local.network-project}"
	name			= "${local.network-name}"
	auto_create_subnetworks	= false
	routing_mode		= "REGIONAL"
}
