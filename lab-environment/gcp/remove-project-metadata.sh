#!/bin/bash

KEYS=$(gcloud compute project-info describe --format="json" | jq -rc '.commonInstanceMetadata.items[].key');

for KEY in $KEYS; do
	echo "Removing key $KEY"; 
	gcloud compute project-info remove-metadata --keys=$KEY
	echo "Removed key $KEY";
done;
