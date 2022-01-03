output "end_of_script_output_1" {
	value 	= "Everything in this world is magic, except to the magician."
}

output "end_of_script_output_2" {
	value 	= "Welcome to WestWorld."
}

output "docker_server_ip_address" {
	value 		= "Docker Host External IP Address: ${google_compute_instance.gcp_instance_docker_server.network_interface.0.access_config.0.nat_ip}"
	description	= "External-facing IP address of the web service exposed by the application on the docker server"
}

output "gke_cluster_name" {
	value		= "${google_container_cluster.gke_cluster.name}"
	description	= "The GKE cluster name. The name must be provided to kubectl to deploy containers onto the cluster"
}

