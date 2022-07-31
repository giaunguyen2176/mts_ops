# Create/Manage ECS cluster using Terraform
    
1. Install terraform: https://www.terraform.io/downloads

2. Init infrastructure

    `terraform init`

3. Create/Update infrastructure

    `terraform apply -var-file=path-to-.tfvars-file`
    
    Eg: `terraform apply -var-file=dev.tfvars`
    
4. Destroy infrastructure (be sure to destroy all services deployed before destroying the cluster)

    `terraform destroy -var-file=path-to-.tfvars-file`
    
    Eg: `terraform destroy -var-file=dev.tfvars`
