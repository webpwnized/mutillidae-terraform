locals {
	utility-server-service-account-id	= "utility-server-service-account"
}

resource "google_service_account" "utility-server-service-account" {
	project		= "${var.project}"
	account_id	= "${local.utility-server-service-account-id}"
	display_name	= "${local.utility-server-service-account-id}"
	description	= "${local.utility-server-service-account-id}"
	disabled	= "false"
}

output "utility-server-service-account-email" {
	value	= "${google_service_account.utility-server-service-account.email}"
	description	= "The e-mail address of the service account. This value should be referenced from any google_iam_policy data sources that would grant the service account privileges."
	sensitive	= "false"
}

output "utility-server-service-account-unique-id" {
	value	= "${google_service_account.utility-server-service-account.unique_id}"
	description	= "The unique id of the service account"
	sensitive	= "false"
}

output "utility-server-service-account-member" {
	value	= "${google_service_account.utility-server-service-account.member}"
	description	= "The Identity of the service account in the form serviceAccount:{email}. This value is often used to refer to the service account in order to grant IAM permissions."
	sensitive	= "false"
}

