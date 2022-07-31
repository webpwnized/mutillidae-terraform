# Mutillidae Terraform Reference Architecture for Google Cloud Platform (GCP)

## Dependencies

### This project
`git clone https://github.com/webpwnized/mutillidae-terraform.git`

### Terrform client software
`sudo apt get install terraform`

### The Google Cloud Platform (GPC) *gcloud* client software

Follow [**the instructions for your distribution**](https://cloud.google.com/sdk/docs/install#linux "the instructions for your distribution")

### A Google Cloud Platform (GPC) project

[How to Create a Project in Google Cloud Platform (GPC)](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)")

### A Google Cloud Platform (GCP) Service Account for Terraform

[How to create a Service Account for Terraform](https://www.youtube.com/watch?v=hMcVrKgX30w "How to create a Service Account for Terraform")

## Configuration

1. Configure the variables in the ***variables.tf.CHANGEME*** file
	1. The variables in the first section must be set by you
	2. The variables in the second section have preset values
	3. The preset values may be modified as needed, but should work by default
5. Save the file as ***variables.tf1***

## How to deploy the project with Terraform

`terraform plan`
`terraform apply`

