This sample app assumes that you have awscli, terraform, helm, kubectl installed.
You should have default aws profile configured via "aws configure" command.
Backend.tf is the config for storing the state file in s3. Default bucket is ops-env-infra in us-east-1, should be changed because of bucket global names.

Steps to deploy cluster:

cd ./terraform/eks
terraform init
terraform plan
terraform apply --auto-approve

The above steps will create file secrets.tfvars in the terraform/applications/sample-application dir, which is crucial for further deployment

After deploying eks deploy sample app with terraform:
cd ../../applications/sample-application/

terraform init
terraform plan --var-file="secrets.tfvars"
terraform apply --var-file="secrets.tfvars" --auto-approve

To deploy sample app with helm, from the root dir of the repo:

aws eks --region us-east-2 update-kubeconfig --name tf-cluster
helm upgrade --install helm-app ./helm

Then wait a bit until ingress alb will be deployed with the public address
kubectl get po,svc,ingress -A


To delete deployment:
helm uninstall helm-app

From the root module:
cd ./terraform/applications/sample-application/
terraform destroy --auto-approve --var-file="secrets.tfvars"

From the root module:
cd ./terraform/eks/
terraform destroy --auto-approve