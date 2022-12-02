
echo "Tearing down the infrastucture using Terraform"
terraform destroy -auto-approve

echo "Deleting the terraform configuration files"
for i in $(cat terraform-files.txt); do rm $i 2>/dev/null; done

echo "Deleting the cloud-init files"
rm -rf cloud-init 2>/dev/null;

echo "Asking Google Cloud to list project metadata keys so they can be removed"
KEYS=$(gcloud compute project-info describe --format="json" | jq -rc 'try .commonInstanceMetadata.items[].key');

if [[ $KEYS != "" ]]; then

	echo "";
	echo "Removing project metadata";
	echo "";

	for KEY in $KEYS; do
		echo "Removing key $KEY"; 
		gcloud compute project-info remove-metadata --keys=$KEY
		echo "Removed key $KEY";
	done;
	echo "";
fi;

echo "";
echo "NOTE: These are the extra files besides the lab files. Its safe to delete files that you created."
echo "";

ls -1 > /tmp/remaining-files.txt;

cat terraform-files.txt > /tmp/lab-files.txt;
echo "build-gcp-lab-environment.sh" >> /tmp/lab-files.txt;
echo "cloud-init-files.txt" >> /tmp/lab-files.txt;
echo "destroy-gcp-lab-environment.sh" >> /tmp/lab-files.txt;
echo "README.md" >> /tmp/lab-files.txt;
echo "terraform-files.txt" >> /tmp/lab-files.txt;
echo "terraform.tfstate" >> /tmp/lab-files.txt;
echo "terraform.tfstate.backup" >> /tmp/lab-files.txt;
echo "variables.tf" >> /tmp/lab-files.txt;
sort -u /tmp/lab-files.txt > /tmp/lab-files-sorted.txt;
mv /tmp/lab-files-sorted.txt /tmp/lab-files.txt;

comm -13 /tmp/lab-files.txt /tmp/remaining-files.txt;

rm /tmp/lab-files.txt /tmp/remaining-files.txt;


