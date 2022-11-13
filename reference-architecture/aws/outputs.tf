output "end_of_script_output_1" {
	value 	= "Everything in this world is magic, except to the magician."
}

output "end_of_script_output_2" {
	value 	= "Welcome to WestWorld."
}

data "aws_availability_zones" "available" {}

output "availability_zones" {
	value 	= data.aws_availability_zones.available.names
}

