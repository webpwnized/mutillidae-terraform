#!/bin/bash

# GET CREDENTIALS TO GKE SERVICE
gcloud container clusters get-credentials mutillidae-gke-cluster

# DEPLOY WORKLOADS
kubectl create deployment mutillidae-database --image=docker.io/webpwnized/mutillidae:database
kubectl expose deployment mutillidae-database --name=database --type=ClusterIP --port=3306 --protocol=TCP --target-port=3306

kubectl create deployment mutillidae-ldap --image=docker.io/webpwnized/mutillidae:ldap
kubectl expose deployment mutillidae-ldap --name=ldap --type=ClusterIP --protocol=TCP --port=389 --target-port=389

kubectl create deployment mutillidae-www --image=docker.io/webpwnized/mutillidae:www
kubectl expose deployment mutillidae-www --name=www --type=LoadBalancer --protocol=TCP --port=80 --target-port=80

kubectl create deployment mutillidae-databaseadmin --image=docker.io/webpwnized/mutillidae:database_admin
kubectl expose deployment mutillidae-databaseadmin --name=databaseadmin --type=LoadBalancer --protocol=TCP --port=80 --target-port=80

kubectl create deployment mutillidae-ldapadmin --image=docker.io/webpwnized/mutillidae:ldap_admin
kubectl expose deployment mutillidae-ldapadmin --name=ldapadmin --type=LoadBalancer --protocol=TCP --port=80 --target-port=80
