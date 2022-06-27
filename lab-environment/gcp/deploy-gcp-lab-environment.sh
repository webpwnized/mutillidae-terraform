# Copy files needed to deploy infrastructure using Terraform
for i in $(cat terraform-files.txt); do cp ../../reference-architecture/gcp/$i .; done

# Copy files needed to configure infrastructure using cloud-init
mkdir cloud-init;
for i in $(cat cloud-init-files.txt); do cp ../../reference-architecture/gcp/cloud-init/$i cloud-init; done

# Deploy the infrastructure using Terraform
terraform init -upgrade
terraform apply -auto-approve
