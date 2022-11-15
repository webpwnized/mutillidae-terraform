locals {
	application-server-service-account-id	= "application-server-service-account"
}

resource "google_service_account" "application-server-service-account" {
	project		= "${var.project}"
	account_id	= "${local.application-server-service-account-id}"
	display_name	= "${local.application-server-service-account-id}"
	description	= "${local.application-server-service-account-id}"
	disabled	= "false"
}

output "application-server-service-account-email" {
	value	= "${google_service_account.application-server-service-account.email}"
	description	= "The e-mail address of the service account. This value should be referenced from any google_iam_policy data sources that would grant the service account privileges."
	sensitive	= "false"
}

output "application-server-service-account-name" {
	value	= "${google_service_account.application-server-service-account.name}"
	description	= "The fully-qualified name of the service account"
	sensitive	= "false"
}

output "application-server-service-account-unique-id" {
	value	= "${google_service_account.application-server-service-account.unique_id}"
	description	= "The unique id of the service account"
	sensitive	= "false"
}

output "application-server-service-account-member" {
	value	= "${google_service_account.application-server-service-account.member}"
	description	= "The Identity of the service account in the form serviceAccount:{email}. This value is often used to refer to the service account in order to grant IAM permissions."
	sensitive	= "false"
}

