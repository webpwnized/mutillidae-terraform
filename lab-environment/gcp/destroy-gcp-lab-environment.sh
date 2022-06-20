
# Tear down the infrastucture using Terraform
terraform destroy -auto-approve

# Delete the terraform configuration files
for i in $(cat terraform-files.txt); do rm $i; done

# Delete the cloud-init files
rm -rf cloud-init;

echo "";
echo "NOTE: There should be 6 files remaining after destruction. If there are more, you probably created lab files that are left over. Its safe to delete files that you created."
echo "";
echo "$(ls -1 | wc -l) files remaining";
echo "---------------------";
echo "";
ls -1;
