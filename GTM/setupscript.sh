#######GTM terraform section

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
mapfile -t file_contents < gtm_variables.txt
for line in "${file_contents[@]}"
do
  var_name="$(echo "$line" | awk -F':' '{print $1}')"
  var_value="$(echo "$line" | awk -F':' '{print $2}')"
  export "$var_name"="$var_value"
done

#update TF variables file with collected information
echo "Update GTM Terraform deplyoment variables file"
envsubst < GTM/gtm_tf/terraform.tfvars.template > GTM/gtm_tf/terraform.tfvars
echo 'terraform.tfvars file generated from terraform.tfvars.template'
echo '-----------'


#Deploy Akamai GTM via Terraform
echo '-----------'
echo "Deploy Akamai GTM via Terraform"
terraform -chdir=GTM/gtm_tf/ init && terraform -chdir=GTM/gtm_tf/ plan && terraform -chdir=GTM/gtm_tf/ apply
echo 'Akamai GTM successfully created.'
echo 'CNAME your applications DNS to '$GTM_PROPERTY_NAME'.'$GTM_DOMAIN_NAME
echo '-----------'
