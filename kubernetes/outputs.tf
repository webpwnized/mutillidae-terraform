output "gke-cluster-endpoint-ip" {
	value 	= google_container_cluster.gke_cluster.endpoint
	description	= "The IP address of this clusters Kubernetes master"
	sensitive	= false
}

output "gke-cluster-master-version" {
	value 	= google_container_cluster.gke_cluster.master_version
	description	= "The current version of the clusters Kubernetes master"
	sensitive	= false
}

output "gke-cluster-services-ip-range" {
	value 	= google_container_cluster.gke_cluster.services_ipv4_cidr
	description	= "The IP address range of the Kubernetes services in this cluster"
	sensitive	= false
}


output "gke-cluster-name" {
	value 	= google_container_cluster.gke_cluster.name
	description	= "The GKE cluster name"
	sensitive	= false
}


