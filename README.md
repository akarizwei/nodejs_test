# Deployment Instructions

This sample app assumes that you have `awscli`, `terraform`, `helm`, and `kubectl` installed. You should have a default AWS profile configured via the `aws configure` command. The `backend.tf` file is configured for storing the state file in S3. The default bucket is `ops-env-infra` in `us-east-1`, which should be changed because of global bucket names.

## Steps to Deploy Cluster:

1. Navigate to the `terraform/eks` directory:
    ```sh
    cd ./terraform/eks
    ```

2. Initialize Terraform:
    ```sh
    terraform init
    ```

3. Review the plan:
    ```sh
    terraform plan
    ```

4. Apply the plan:
    ```sh
    terraform apply --auto-approve
    ```

    The above steps will create a `secrets.tfvars` file in the `terraform/applications/sample-application` directory, which is crucial for further deployment.

## Deploy Sample App with Terraform:

1. Navigate to the sample application directory:
    ```sh
    cd ../../applications/sample-application/
    ```

2. Initialize Terraform:
    ```sh
    terraform init
    ```

3. Review the plan with the `secrets.tfvars` file:
    ```sh
    terraform plan --var-file="secrets.tfvars"
    ```

4. Apply the plan with the `secrets.tfvars` file:
    ```sh
    terraform apply --var-file="secrets.tfvars" --auto-approve
    ```

## Deploy Sample App with Helm:

1. From the root directory of the repo, update the kubeconfig for your EKS cluster:
    ```sh
    aws eks --region us-east-2 update-kubeconfig --name tf-cluster
    ```

2. Install or upgrade the Helm chart:
    ```sh
    helm upgrade --install helm-app ./helm
    ```

3. Wait a bit until the ingress ALB is deployed with the public address. Then, check the status:
    ```sh
    kubectl get po,svc,ingress -A
    ```

## To Delete Deployment:

1. Uninstall the Helm release:
    ```sh
    helm uninstall helm-app
    ```

2. Destroy the Terraform deployment for the sample application:
    ```sh
    cd ./terraform/applications/sample-application/
    terraform destroy --auto-approve --var-file="secrets.tfvars"
    ```

3. Destroy the Terraform deployment for the EKS cluster:
    ```sh
    cd ./terraform/eks/
    terraform destroy --auto-approve
    ```
