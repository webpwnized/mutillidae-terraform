
# Tear down the infrastucture using Terraform
terraform destroy -auto-approve

# Delete the terraform configuration files
for i in $(cat terraform-files.txt); do rm $i; done

# Delete the cloud-init files
rm -rf cloud-init;

KEYS=$(gcloud compute project-info describe --format="json" | jq -rc '.commonInstanceMetadata.items[].key');

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
ls -1 > /tmp/remaining-files.txt
sort -u terraform-files.txt > /tmp/lab-files.txt
comm -1 /tmp/lab-files.txt /tmp/remaining-files.txt;
rm /tmp/lab-files.txt /tmp/remaining-files.txt;
