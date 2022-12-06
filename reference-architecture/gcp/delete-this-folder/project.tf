resource "random_string" "random_number" {
	numeric		= "true"
	length		= "10"
	min_numeric	= "10"
	lower		= "false"
	special		= "false"
	upper		= "false"
}

output "random-number-value" {
	value		= "${random_string.random_number.result}"
	description	= "Random number used to make the project name unique"
	sensitive	= "false"
}

resource "google_project" "mutillidae-terraform" {
	name       = "Mutillidae ${random_string.random_number.result}"
	project_id = "${var.project-name}-${random_string.random_number.result}"
	billing_account	= "${var.billing-account}"
}
