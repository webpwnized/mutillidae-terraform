locals {
	network-project		= "${var.project}"
	network-name		= "mutillidae-vpc-t"
	iaas-subnet-project	= "${google_compute_network.gcp_vpc_network.project}"
	iaas-subnet-region	= "${var.region}"
	iaas-subnet-network	= "${google_compute_network.gcp_vpc_network.name}"
	iaas-subnet-name	= "${google_compute_network.gcp_vpc_network.name}-iaas-subnet"
	k8s-subnet-project	= "${google_compute_network.gcp_vpc_network.project}"
	k8s-subnet-region	= "${var.region}"
	k8s-subnet-network	= "${google_compute_network.gcp_vpc_network.name}"
	k8s-subnet-name		= "${google_compute_network.gcp_vpc_network.name}-kubernetes-subnet"
}

resource "google_compute_network" "gcp_vpc_network" {
	project			= "${local.network-project}"
	name			= "${local.network-name}"
	auto_create_subnetworks	= false
	routing_mode		= "REGIONAL"
}

resource "google_compute_subnetwork" "gcp_vpc_iaas_subnetwork" {
	project		= "${local.iaas-subnet-project}"
	region		= "${local.iaas-subnet-region}"
	network		= "${local.iaas-subnet-network}"
	name		= "${local.iaas-subnet-name}"
	ip_cidr_range	= "10.0.0.0/28"
}

resource "google_compute_subnetwork" "gcp_vpc_kubernetes_subnetwork" {
	project		= "${local.k8s-subnet-project}"
	region		= "${local.k8s-subnet-region}"
	network		= "${local.k8s-subnet-network}"
	name		= "${local.k8s-subnet-name}"
	ip_cidr_range	= "10.0.1.0/28"
}
