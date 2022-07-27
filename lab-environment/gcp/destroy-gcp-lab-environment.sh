
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
echo "NOTE: There should be 7 files remaining after destruction. If there are more, you probably created lab files that are left over. Its safe to delete files that you created."
echo "";
echo "$(ls -1 | wc -l) files remaining";
echo "---------------------";
echo "";
ls -1;
