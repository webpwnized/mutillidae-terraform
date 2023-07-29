
resource "google_compute_project_metadata" "project-metadata" {
	project		= "${var.project}"
	metadata	= {
		block-project-ssh-keys 	= "TRUE"
		enable-oslogin 		= "TRUE"
		enable-oslogin-2fa	= "TRUE"
		enable-osconfig		= "TRUE"
		serial-port-enable	= "FALSE"
	}
}

