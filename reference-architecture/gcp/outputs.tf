data "google_client_openid_userinfo" "current_user" {

}

output "end_of_script_output_1" {
	value 	= "Everything in this world is magic, except to the magician."
}

output "end_of_script_output_2" {
	value 	= "Welcome to WestWorld."
}

output "region" {
	value 	= "${var.region}"
}

output "zone" {
	value 	= "${var.zone}"
}

output "google-client-openid-current-user-info" {
	value 		= "${data.google_client_openid_userinfo.current_user}"
	description	= "The current user running this Terraform script"
}

