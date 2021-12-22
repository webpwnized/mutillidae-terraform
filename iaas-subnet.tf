locals {
	iaas-subnet-project	= "${google_compute_network.gcp_vpc_network.project}"
	iaas-subnet-region	= "${var.region}"
	iaas-subnet-network	= "${google_compute_network.gcp_vpc_network.name}"
	iaas-subnet-name	= "${google_compute_network.gcp_vpc_network.name}-iaas-subnet"
}

resource "google_compute_subnetwork" "gcp_vpc_iaas_subnetwork" {
	project		= "${local.iaas-subnet-project}"
	region		= "${local.iaas-subnet-region}"
	network		= "${local.iaas-subnet-network}"
	name		= "${local.iaas-subnet-name}"

	ip_cidr_range	= "10.0.0.0/28"
}
