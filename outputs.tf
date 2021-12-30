output "end_of_script_output_1" {
	value 	= "Everything in this world is magic, except to the magician."
}

output "end_of_script_output_2" {
	value 	= "Welcome to WestWorld."
}

output "docker_host_output" {
	value 	= "Docker Host External IP Address: ${google_compute_instance.gcp_instance_docker_host.network_interface.0.access_config.0.nat_ip}"
}

