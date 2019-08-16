# terraform

Below are the pre-requisites before to execute the make stuff

s3 bucket - dev-terraform-state ( Can be referenced from environment variable as well. Override in the Makefile )

EC2 Key-Pair - testking ( EC2 key pair to be created ahead in time )

export AWS_ACCESS_KEY_ID=xxxxx

export AWS_SECRET_ACCESS_KEY=xxxxx


Once the AWS Credentials are set

Execute make terraform-plan, to generate the TF Plan

If all is looking good, execute terraform-apply to deploy the infrastructure.


**NOTE: The runners need a Project Token to register themselves to the server. If a project token is not mentioned in the gitlab-runners.tfvars file, the runner instances are not deployed

I've used the Official terraform Module for the Security Group avialable at registry.terraform.io

