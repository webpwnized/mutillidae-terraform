
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network

locals {
	network-name		= "${var.application-name}-vpc"
}

resource "google_compute_network" "gcp_vpc_network" {
	project				= "${var.project}"
	description			= "The VPC network for this project"
	name				= "${local.network-name}"
	auto_create_subnetworks		= false
	routing_mode			= "REGIONAL"
	delete_default_routes_on_create	= "false"
}

output "vpc-gateway-ip-address" {
	value 		= "${google_compute_network.gcp_vpc_network.gateway_ipv4}"
	description	= "The gateway address for default routing out of the network. This value is selected by GCP."
}

