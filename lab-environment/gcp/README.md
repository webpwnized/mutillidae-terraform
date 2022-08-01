# Mutillidae Terraform Google Cloud Platform Lab Environment

This project contains reference architectures for Google Cloud Platform (GCP) and Microsoft Azure Cloud. The project also contains scripts to generate a deliberately insecure lab environment. The lab environment can be used for demonstrations and in classwork.

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

[How to Create a Service Account for Terraform](https://www.youtube.com/watch?v=hMcVrKgX30w "How to Create a Service Account for Terraform")

## Installation Instructions

1. Clone this project
2. Configure the variables in the ***variables.tf*** file at the root of this project
3. Install, initialize, and authenticate the Google ***gcloud*** client software
4. Install the ***terraform*** client software
5. [Create a project](https://www.youtube.com/watch?v=qUgfKkeJ29Y "How to Create a Project in Google Cloud Platform (GPC)") in Google Cloud Platform (GCP). Configure the project name in the ***variables.tf*** file.
6. Create a service account in the Google Cloud Platform (GCP) project
7. Create a service account key for the service account
8. Place the service account key in a file. Configure the service account key location in the ***variables.tf*** file.
9. Deploy the lab

### How to deploy the lab

`./deploy-gcp-lab-environment.sh`

