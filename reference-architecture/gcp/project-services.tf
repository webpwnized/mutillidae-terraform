resource "google_project_service" "compute-service" {
	project                      = "${var.project}"
	service                      = "compute.googleapis.com"
	disable_on_destroy           = "false"  # Do not disable this service when destroying resources
	disable_dependent_services  = "false"  # Do not disable dependent services when destroying resources
}

resource "google_project_service" "osconfig-service" {
	project                      = "${var.project}"
	service                      = "osconfig.googleapis.com"
	disable_on_destroy           = "true"   # Disable this service when destroying resources
	disable_dependent_services  = "true"   # Disable dependent services when destroying resources
}

resource "google_project_service" "containeranalysis-service" {
	project                      = "${var.project}"
	service                      = "containeranalysis.googleapis.com"
	disable_on_destroy           = "true"   # Disable this service when destroying resources
	disable_dependent_services  = "true"   # Disable dependent services when destroying resources
}

resource "google_project_service" "serviceusage-service" {
	project                      = "${var.project}"
	service                      = "serviceusage.googleapis.com"
	# The service usage API is required to list enabled services, 
	# which creates a chicken and egg problem. Terraform cannot 
	# list available or enabled services with the Service Usage 
	# API, which prevents Terraform from pre-checking the API as 
	# part of the service enabling process. The Service Usage API 
	# has to be left enabled. 
	disable_on_destroy           = "false"  # Do not disable this service when destroying resources
	disable_dependent_services  = "false"  # Do not disable dependent services when destroying resources
}
