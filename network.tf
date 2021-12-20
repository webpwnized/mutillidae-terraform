locals {
	network-project	= "${var.project}"
	network-region	= "${var.region}"
	network-name	= "mutillidae-vpc-t"
}

resource "google_compute_network" "gcp_vpc_network" {
	project			= "${local.network-project}"
	name			= "${local.network-name}"
	auto_create_subnetworks	= false
	routing_mode		= "REGIONAL"
}

resource "google_compute_subnetwork" "gcp_vpc_iaas_subnetwork" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	region		= "${local.network-region}"
	name		= "${google_compute_network.gcp_vpc_network.name}-iaas-subnet-t"
	ip_cidr_range	= "10.0.0.0/28"
	network		= "${google_compute_network.gcp_vpc_network.name}"
}

resource "google_compute_subnetwork" "gcp_vpc_kubernetes_subnetwork" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	region		= "${local.network-region}"
	name		= "${google_compute_network.gcp_vpc_network.name}-kubernetes-subnet-t"
	ip_cidr_range	= "10.0.1.0/28"
	network		= "${google_compute_network.gcp_vpc_network.name}"
}

resource "google_compute_router" "gcp-vpc-nat-router" {
	project		= "${google_compute_network.gcp_vpc_network.project}"
	region  	= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.region}"
	network 	= "${google_compute_network.gcp_vpc_network.name}"
	name		= "${google_compute_network.gcp_vpc_network.name}-nat-router"
	description	= "NAT router to proxy egress traffic outbound for the ${google_compute_network.gcp_vpc_network.name} network"
}

resource "google_compute_router_nat" "gcp-vpc-nat-router-nat-service" {
	project					= "${google_compute_network.gcp_vpc_network.project}"
	region                             	= "${google_compute_router.gcp-vpc-nat-router.region}"
	name					= "${google_compute_router.gcp-vpc-nat-router.name}-nat-service"
	router					= "${google_compute_router.gcp-vpc-nat-router.name}"
	nat_ip_allocate_option			= "AUTO_ONLY"
	source_subnetwork_ip_ranges_to_nat	= "LIST_OF_SUBNETWORKS"
	
	subnetwork {
		name			= "${google_compute_subnetwork.gcp_vpc_iaas_subnetwork.name}"
		source_ip_ranges_to_nat	= ["PRIMARY_IP_RANGE"]
	}

	log_config {
		enable = true
		filter = "ALL"
	}
}
