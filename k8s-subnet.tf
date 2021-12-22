locals {
	k8s-subnet-project	= "${google_compute_network.gcp_vpc_network.project}"
	k8s-subnet-region	= "${var.region}"
	k8s-subnet-network	= "${google_compute_network.gcp_vpc_network.name}"
	k8s-subnet-name		= "${google_compute_network.gcp_vpc_network.name}-kubernetes-subnet"
}

resource "google_compute_subnetwork" "gcp_vpc_kubernetes_subnetwork" {
	project		= "${local.k8s-subnet-project}"
	region		= "${local.k8s-subnet-region}"
	network		= "${local.k8s-subnet-network}"
	name		= "${local.k8s-subnet-name}"

	ip_cidr_range	= "10.0.1.0/28"
}
