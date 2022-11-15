
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

locals {
	application-server-subnet-project	= "${google_compute_network.gcp_vpc_network.project}"
	application-server-subnet-region	= "${var.region}"
	application-server-subnet-network	= "${google_compute_network.gcp_vpc_network.name}"
	application-server-subnet-name		= "application-server-subnet"
	application-server-subnet-description	= "VPC subnet to deploy application servers"
	
	application-server-subnet-ip-address-range	= "${var.application-server-subnet-ip-address-range}"
}

resource "google_compute_subnetwork" "gcp-vpc-application-server-subnetwork" {
	project		= "${local.application-server-subnet-project}"
	region		= "${local.application-server-subnet-region}"
	network		= "${local.application-server-subnet-network}"
	name		= "${local.application-server-subnet-name}"
	description	= "${local.application-server-subnet-description}"

	ip_cidr_range	= "${local.application-server-subnet-ip-address-range}"
	private_ip_google_access	= "true"
	
	log_config {
		aggregation_interval	= "INTERVAL_5_SEC"
		flow_sampling		= "0.25"
		metadata		= "INCLUDE_ALL_METADATA"
		filter_expr		= "true"
	}
}

output "application-server-subnetwork-gateway-address" {
	value 		= "${google_compute_subnetwork.gcp-vpc-application-server-subnetwork.gateway_address}"
	description	= "The gateway address for default routes to reach destination addresses outside this subnetwork"
}

