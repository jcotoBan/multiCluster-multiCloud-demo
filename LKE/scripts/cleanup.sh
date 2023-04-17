#!/bin/bash

kubectl delete svc guestbookfrontend
kubectl delete svc redis-follower
kubectl delete svc redis-leader

terraform -chdir=LKE/clusters/clustersworkdir destroy -auto-approve \
 -var-file="clusters.tfvars"

