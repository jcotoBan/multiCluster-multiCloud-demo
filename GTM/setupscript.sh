#!/bin/bash

#GTM terraform

echo '-----------'
echo "Fetch external IPs of LKE Clusters"
touch ./GTM/gtm_tf/locations.txt

export USWEST=$(kubectl get service frontend --kubeconfig=kubeconfig_us.yaml -o json | jq -r '.status.loadBalancer.ingress[0].ip')
echo "USWEST: " $USWEST
echo "USWEST: " $USWEST >> ./GTM/gtm_tf/locations.txt

export EUWEST=$(kubectl get service frontend --kubeconfig=kubeconfig_eu.yaml -o json | jq -r '.status.loadBalancer.ingress[0].ip')
echo "EUWEST: " $EUWEST
echo "EUWEST: " $EUWEST >> ./GTM/gtm_tf/locations.txt

export APNORTHEAST=$(kubectl get service frontend --kubeconfig=kubeconfig_ap.yaml -o json | jq -r '.status.loadBalancer.ingress[0].ip')
echo "APNORTHEAST: " $APNORTHEAST
echo "APNORTHEAST: " $APNORTHEAST >> ./GTM/gtm_tf/locations.txt

echo '-----------'
echo './GTM/gtm_tf/locations.txt'
cat ./GTM/gtm_tf/locations.txt
echo '-----------'

# Collect Akamai GTM input information
echo "Define Akamai GTM variables"
touch ./GTM/gtm_tf/gtm_variables.txt
read -p "Enter Akamai Contract ID: " AKAM_CONTRACT_ID
echo "AKAM_CONTRACT_ID: " $AKAM_CONTRACT_ID >> ./GTM/gtm_tf/gtm_variables.txt
read -p "Enter Akamai Group ID: " AKAM_GROUP_ID
echo "AKAM_GROUP_ID: " $AKAM_GROUP_ID >> ./GTM/gtm_tf/gtm_variables.txt
read -p "Enter Akamai GTM notification email: " GTM_NOTIFICATION_EMAIL
echo "GTM_NOTIFICATION_EMAIL: " $GTM_NOTIFICATION_EMAIL >> ./GTM/gtm_tf/gtm_variables.txt
read -p "Enter Akamai GTM Domain name (must end with .akadns.net): " GTM_DOMAIN_NAME
echo "GTM_DOMAIN_NAME: " $GTM_DOMAIN_NAME >> ./GTM/gtm_tf/gtm_variables.txt
read -p "Enter Akamai GTM Property name: " GTM_PROPERTY_NAME
echo "GTM_PROPERTY_NAME: " $GTM_PROPERTY_NAME >> ./GTM/gtm_tf/gtm_variables.txt
echo '-----------'
echo "GTM Connfiguration"
echo "AKAM_CONTRACT_ID: $AKAM_CONTRACT_ID"
echo "AKAM_GROUP_ID: $AKAM_GROUP_ID"
echo "GTM_NOTIFICATION_EMAIL: $GTM_NOTIFICATION_EMAIL"
echo "GTM_DOMAIN_NAME: $GTM_DOMAIN_NAME"
echo "GTM_PROPERTY_NAME: $GTM_PROPERTY_NAME"
echo '-----------'
echo './GTM/gtm_tf/gtm_variables.txt'
cat ./GTM/gtm_tf/gtm_variables.txt
echo '-----------'

export AKAM_CONTRACT_ID
export AKAM_GROUP_ID
export GTM_NOTIFICATION_EMAIL
export GTM_DOMAIN_NAME
export GTM_PROPERTY_NAME

#update TF variables file with collected information
cd GTM/gtm_tf
echo "Update GTM Terraform deplyoment variables file"
envsubst < terraform.tfvars.template > terraform.tfvars
echo 'terraform.tfvars file generated from terraform.tfvars.template'
echo '-----------'


#Deploy Akamai GTM via Terraform
echo '-----------'
echo "Deploy Akamai GTM via Terraform"
terraform init && terraform plan && terraform apply
echo 'Akamai GTM successfully created.'
echo 'CNAME your applications DNS to '$GTM_PROPERTY_NAME'.'$GTM_DOMAIN_NAME
echo '-----------'

cd ..