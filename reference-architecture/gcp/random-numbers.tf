
# TODO: Need a better keeper than current date
resource "random_pet" "random_suffix" {
	keepers = {
		keeper = "${md5(formatdate("DD MMM YYYY", timestamp()))}"
	}
	length	= 1
}

output "database_name_random_pet" {
	value 		= "${random_pet.random_suffix.id}"
	description	= "The random pet name assigned to the database name"
}

output "database_name_random_pet_keepers" {
	value 		= "${random_pet.random_suffix.keepers}"
	description	= "The random pet keeper"
}

