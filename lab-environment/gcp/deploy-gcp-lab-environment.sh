
for i in $(cat terraform-files.txt); do cp ../../reference-architecture/gcp/$i .; done

mkdir cloud-init;

for i in $(cat cloud-init-files.txt); do cp ../../reference-architecture/gcp/cloud-init/$i cloud-init; done

