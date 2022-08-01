#Terraform is amazing!

Name: Giau Nguyen

Email: minhgiau.nguyen@gmail.com

All related resources in this document:

1. Database schema: https://github.com/giaunguyen2176/mts_api/blob/main/migrations/schema.sql

2. Repositories:

    - Backend: https://github.com/giaunguyen2176/mts_api
    - Frontend: https://github.com/giaunguyen2176/mts_web
    - DevOps: https://github.com/giaunguyen2176/mts_ops

3. Frontend: https://mts.escape30.com

4. Backend link: 

    - GET https://api.mts.escape30.com/api/v1/private/users
    - GET https://api.mts.escape30.com/api/v1/private/users/:email
    - POST https://api.mts.escape30.com/api/v1/users
    
    For private endpoints authentication, add header `x-api-key=8MWNZg05XZYtpAFZYwnA2n7Uu3hx90j7` to the request.

5. AWS credentials:

    `username=tester`
    `password=mts@tester2022`

##How to deploy your API backend and/or frontend websites to ECS with Terraform?

###1. Prerequisites

- An AWS account
- A valid domain that you have credentials to login to manage DNS records
- Terraform CLI installed, you can download the installer depends on your OS here: https://www.terraform.io/downloads


###2. Prepare your AWS user and permissions

Because we will use terraform to manage resources from AWS, Terraform requires multiple permissions depends on services or resources you use.

We will use `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, to provide Terraform the necessary access to AWS resources.

So heads to AWS console and generate a new pair of `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. You can you the root account to generate this pair,
but it's a best practice to limit the permissions one user can use, so it's good to just create a new user and generate a new pair from that user.

The user will require many permissions to perform Terraform's tasks, skip this step if you use key pair generated from root account or a full permissions user.
Heads to IAM console of AWS and create a new user, then create a new policies named `Terraform` with below permissions:

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": [
                    "ecs:UntagResource",
                    "sts:GetCallerIdentity",
                    "ec2:DescribeAccountAttributes",
                    "route53:ListHostedZones",
                    "ecs:DescribeClusters",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeVpcs",
                    "iam:GetRole",
                    "rds:DescribeDBSubnetGroups",
                    "ec2:DescribeVpcAttribute",
                    "acm:DescribeCertificate",
                    "acm:ListTagsForCertificate",
                    "rds:DescribeDBInstances",
                    "ec2:DescribeRouteTables",
                    "route53:GetHostedZone",
                    "ec2:DescribeSubnets",
                    "rds:ListTagsForResource",
                    "route53:ListTagsForResource",
                    "elasticloadbalancing:DescribeTargetGroups",
                    "elasticloadbalancing:DescribeLoadBalancers",
                    "elasticloadbalancing:DescribeLoadBalancerAttributes",
                    "elasticloadbalancing:DescribeTargetGroupAttributes",
                    "route53:ListResourceRecordSets",
                    "elasticloadbalancing:DescribeTags",
                    "ecs:DescribeTaskDefinition",
                    "ecs:DescribeServices",
                    "elasticloadbalancing:DescribeListeners",
                    "application-autoscaling:DescribeScalableTargets",
                    "application-autoscaling:DescribeScalingPolicies",
                    "ecs:DeregisterTaskDefinition",
                    "rds:CreateDBInstance",
                    "rds:AddTagsToResource",
                    "ecs:RegisterTaskDefinition",
                    "ecs:UpdateService",
                    "elasticloadbalancing:DeleteListener",
                    "application-autoscaling:DeleteScalingPolicy",
                    "application-autoscaling:DeregisterScalableTarget",
                    "route53:ChangeResourceRecordSets",
                    "ecs:DeleteService",
                    "route53:GetChange",
                    "acm:DeleteCertificate",
                    "elasticloadbalancing:DeleteLoadBalancer",
                    "elasticloadbalancing:DeleteTargetGroup",
                    "rds:DeleteDBInstance",
                    "ec2:DescribeNetworkInterfaces",
                    "ec2:DetachNetworkInterface",
                    "ec2:DeleteNetworkInterface",
                    "iam:GetPolicy",
                    "ec2:DescribeVpcClassicLink",
                    "iam:GetPolicyVersion",
                    "iam:ListRolePolicies",
                    "ec2:DescribeVpcClassicLinkDnsSupport",
                    "iam:ListAttachedRolePolicies",
                    "ec2:DescribeNetworkAcls",
                    "ec2:DescribeInternetGateways",
                    "ecs:PutClusterCapacityProviders",
                    "ec2:DisassociateRouteTable",
                    "ec2:DeleteRoute",
                    "iam:DetachRolePolicy",
                    "rds:DeleteDBSubnetGroup",
                    "ec2:DeleteSubnet",
                    "ec2:DeleteSecurityGroup",
                    "iam:ListPolicyVersions",
                    "iam:ListInstanceProfilesForRole",
                    "iam:DeletePolicy",
                    "ec2:DetachInternetGateway",
                    "iam:DeleteRole",
                    "ec2:DeleteRouteTable",
                    "ec2:DeleteInternetGateway",
                    "ec2:DeleteVpc",
                    "ecs:DeleteCluster",
                    "iam:CreateRole",
                    "iam:CreatePolicy",
                    "ecs:CreateCluster",
                    "ec2:CreateVpc",
                    "ec2:CreateTags",
                    "iam:AttachRolePolicy",
                    "ec2:CreateSubnet",
                    "ec2:CreateInternetGateway",
                    "ec2:CreateRouteTable",
                    "ec2:CreateSecurityGroup",
                    "ec2:AttachInternetGateway",
                    "ec2:ModifySubnetAttribute",
                    "ec2:RevokeSecurityGroupEgress",
                    "ec2:CreateRoute",
                    "ec2:AuthorizeSecurityGroupIngress",
                    "ec2:AuthorizeSecurityGroupEgress",
                    "ec2:AssociateRouteTable",
                    "rds:CreateDBSubnetGroup",
                    "acm:RequestCertificate",
                    "elasticloadbalancing:CreateLoadBalancer",
                    "elasticloadbalancing:CreateTargetGroup",
                    "elasticloadbalancing:ModifyTargetGroupAttributes",
                    "elasticloadbalancing:ModifyLoadBalancerAttributes",
                    "elasticloadbalancing:SetSecurityGroups",
                    "elasticloadbalancing:CreateListener",
                    "ecs:CreateService",
                    "iam:PassRole",
                    "application-autoscaling:RegisterScalableTarget",
                    "application-autoscaling:PutScalingPolicy"
                ],
                "Resource": "*"
            }
        ]
    }

Attach the created user to above policy, then generate a new `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_ID` from that user

To use your IAM credentials to authenticate the Terraform AWS provider, set the `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` environment variable.

    export AWS_ACCESS_KEY_ID=<generated-value>
    export AWS_SECRET_ACCESS_KEY=<generated-value>
    
    
Keep this terminal open, and perform all commands later in this terminal window, if you use a new terminal window, be sure to rerun above command.

###3. Prepare domains for your backend/frontend

We want our services/web urls to looks fancy like: https://api.mts.yourdomain.com, not just some random url generated by AWS by default

Heads to AWS Route53 console and create a public hosted zone, for example: `mts.yourdomain.com`. Remember to replace yourdomain.com to your actual domain

After the hosted zone is created, notices the value of default NS record created by AWS, something likes:

    ns-1455.awsdns-53.org.
    ns-1884.awsdns-43.co.uk.
    ns-965.awsdns-56.net.
    ns-17.awsdns-02.com.

Copy one of above values (without the dot at the end)

Now, heads to DNS management console of your owned domain, create a new DNS record with:

	type 	= NS
	name 	= mts
	value 	= the value that you have copied from above, for example: ns-1455.awsdns-53.org

Value of `name` here is corresponding to the left most part of your hosted zone, if your hosted zone is `mts.yourdomain.com` then `name` will be `mts`

Sometime DNS management console require `name` to be full-qualified domain, for example `mts.yourdomain.com`, so be sure to check with your domain provider which syntax you should use. DNS update will sometime to be updated across the internet.

To verify that above DNS configuration is working, heads to https://dnschecker.org and verify as below:

	value = mts.yourdomain.com (again remember to replace yourdomain.com to your actual domain)
	type = NS

The website should present a bunch of green ticks and show you the values corresponding to default NS record created by AWS.

The reason we needs to do this is because we want to have SSL served by our services, and we use Terraform to automatically process with DNS validation on your domain then generates a valid ACM SSL certificate without us doing the manual DNS validation.

###4. Terraform-ing our ECS cluster with all the necessary configuration

Clone the repository mts_ops into your local computer:

`git clone git@github.com:giaunguyen2176/mts_ops.git`

All AWS resources, data, etc were described in this repository

Just open your terminal, cd into the project folder and execute command:

`terraform init`

then:

`terraform apply -var-file=dev.tfvars`

If later, you want to remove all resources, perform this command:

`terraform destroy -var-file=dev.tfvars`


Remember to type `yes` as confirmation.

###5. Terraform-ing service for our backend:

Clone the repository mts_api into your local computer:

`git clone git@github.com:giaunguyen2176/mts_api.git`

Open ops/dev.tfvars file and and change below variables:

    r53_zone=<your-hosted-zone-created-in-step-3>
    r53_endpoint=<your-desired-host-for-this-backend-service>
    
`r53_zone` is the hosted zone you've created in step 3, for example: `mts.yourdomain.com`

`r53_endpoint` is the domain url of your choice to access this service from frontend, for example: `api.mts.yourdomain.ccom`

All AWS resources, data, etc, ... related to this backend service, were described in /ops folder

Just open your terminal, cd into /ops folder inside project folder and execute command:

`terraform init`

then:

`terraform apply -var-file=dev.tfvars`

If later, you want to remove all resources, perform this command:

`terraform destroy -var-file=dev.tfvars`

Remember to type `yes` as confirmation.

###6. Terraform-ing service for our frontend:

Clone the repository mts_web into your local computer:

`git clone git@github.com:giaunguyen2176/mts_web.git`

Open ops/dev.tfvars file and and change below variables:

    r53_zone=<your-hosted-zone-created-in-step-3>
    r53_endpoint=<your-desired-host-for-this-website>
    
`r53_zone` is the hosted zone you've created in step 3, for example: `mts.yourdomain.com`

`r53_endpoint` is the domain url of your choice to access this website from the internet, for example: `mts.yourdomain.ccom`

Then, we need to point the frontend to the correct endpoint of the backend service which we were created in step 5.

So, open `src/index.html` file and go to line 158, replace current domain url (eg: https://api.mts.escape30.com) 
with the backend endpoint that you have choose in step 5, for example: https://api.mts.yourdomain.com.

All AWS resources, data, etc, ... related to this backend service, were described in /ops folder

Just open your terminal, cd into /ops folder inside project folder and execute command:

`terraform init`

then:

`terraform apply -var-file=dev.tfvars`


If later, you want to remove all resources, perform this command:

`terraform destroy -var-file=dev.tfvars`

Remember to type `yes` as confirmation.

