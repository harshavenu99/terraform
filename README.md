# terraform

Below are the pre-requisites before to execute the make stuff

export AWS_ACCESS_KEY_ID=xxxxx
export AWS_SECRET_ACCESS_KEY=xxxxx


Once the AWS Credentials are set

Execute make terraform-plan, to generate the TF Plan

If all is looking good, execute terraform-apply to deploy the infrastructure.

The runners need a Project Token to register themselves to the server. If a project token is not mentioned in the gitlab-runners.tfvars file, the runner instances are not deployed

