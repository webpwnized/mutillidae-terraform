locals {
	iaas-subnet-project	= "${google_compute_network.gcp_vpc_network.project}"
	iaas-subnet-region	= "${var.region}"
	iaas-subnet-network	= "${google_compute_network.gcp_vpc_network.name}"
	iaas-subnet-name	= "${google_compute_network.gcp_vpc_network.name}-iaas-subnet"
	iaas-subnet-description	= "VPC subnet to deploy IaaS application servers"
}

resource "google_compute_subnetwork" "gcp_vpc_iaas_subnetwork" {
	project		= "${local.iaas-subnet-project}"
	region		= "${local.iaas-subnet-region}"
	network		= "${local.iaas-subnet-network}"
	name		= "${local.iaas-subnet-name}"
	description	= "${local.iaas-subnet-description}"

	ip_cidr_range	= "10.0.0.0/28"
	log_config {
		aggregation_interval	= "INTERVAL_5_SEC"
		flow_sampling		= "0.25"
		metadata		= "INCLUDE_ALL_METADATA"
		filter_expr		= "true"
	}
}
