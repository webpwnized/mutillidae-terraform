# Copy files needed to deploy infrastructure using Terraform
for i in $(cat terraform-files.txt); do cp ../../reference-architecture/gcp/$i .; done

# Copy files needed to configure infrastructure using cloud-init
mkdir cloud-init;
for i in $(cat cloud-init-files.txt); do cp ../../reference-architecture/gcp/cloud-init/$i cloud-init; done

# Remove security controls from Terraform files so the lab user can fix the issues
##	Remove the block project-wide SSH keys protection from the compute instances
sed -i '/block-project-ssh-keys	= "TRUE"/d' ./bastion-host.tf
sed -i '/block-project-ssh-keys	= "TRUE"/d' ./utility-server.tf
sed -i 's/# Lab-22-Anchor-Point/serial-port-enable	= "TRUE"/' ./bastion-host.tf
sed -i 's/# Lab-22-Anchor-Point/serial-port-enable	= "TRUE"/' ./utility-server.tf

# Deploy the infrastructure using Terraform
terraform init -upgrade
terraform apply -auto-approve
