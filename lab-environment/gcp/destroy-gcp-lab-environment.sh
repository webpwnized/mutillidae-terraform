
# Tear down the infrastucture using Terraform
terraform destroy -auto-approve

# Delete the terraform configuration files
for i in $(cat terraform-files.txt); do rm $i; done

# Delete the cloud-init files
rm -rf cloud-init;

echo "Remaining Files";
echo "";
ls -1;
