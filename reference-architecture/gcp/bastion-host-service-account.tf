locals {
	bastion-host-service-account-id	= "bastion-host-service-account"
}

resource "google_service_account" "bastion-host-service-account" {
	project		= "${var.project}"
	account_id	= "${local.bastion-host-service-account-id}"
	display_name	= "${local.bastion-host-service-account-id}"
	description	= "${local.bastion-host-service-account-id}"
	disabled	= "false"
}

output "bastion-host-service-account-email" {
	value	= "${google_service_account.bastion-host-service-account.email}"
	description	= "The e-mail address of the service account. This value should be referenced from any google_iam_policy data sources that would grant the service account privileges."
	sensitive	= "false"
}

output "bastion-host-service-account-unique-id" {
	value	= "${google_service_account.bastion-host-service-account.unique_id}"
	description	= "The unique id of the service account"
	sensitive	= "false"
}

output "bastion-host-service-account-member" {
	value	= "${google_service_account.bastion-host-service-account.member}"
	description	= "The Identity of the service account in the form serviceAccount:{email}. This value is often used to refer to the service account in order to grant IAM permissions."
	sensitive	= "false"
}

