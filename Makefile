export environment = dev
export region = ap-southeast-2

terraform-plan:

		@terraform init \
			-backend-config="bucket=${environment}-terraform-state" \
                        -backend-config="profile=${environment}" \
    			-backend-config="key=terraform.tfstate" \
    			-backend-config="region=${region}" \
			${environment}/terraform-configs

		@terraform plan -out=infra.txt \
			-var-file=${environment}/terraform-params/main.tfvars \
			-var-file=${environment}/terraform-params/bastion.tfvars \
			-var-file=${environment}/terraform-params/securitygroup.tfvars \
			-var-file=${environment}/terraform-params/gitlab-runners.tfvars \
			-var-file=${environment}/terraform-params/gitlab-server.tfvars \
			${environment}/terraform-configs

terraform-apply:

		@terraform init \
			-backend-config="bucket=${environment}-terraform-state" \
                        -backend-config="profile=${environment}" \
    			-backend-config="key=terraform.tfstate" \
    			-backend-config="region=${region}" \
			${environment}/terraform-configs

		@terraform apply infra.txt

terraform-destroy:

		@terraform init \
			-backend-config="bucket=${environment}-terraform-state" \
                        -backend-config="profile=${environment}" \
    			-backend-config="key=terraform.tfstate" \
    			-backend-config="region=${region}" \
			${environment}/terraform-configs

		@terraform  destroy \
			-var-file=${environment}/terraform-params/main.tfvars \
			-var-file=${environment}/terraform-params/bastion.tfvars \
			-var-file=${environment}/terraform-params/securitygroup.tfvars \
			-var-file=${environment}/terraform-params/gitlab-runners.tfvars \
			-var-file=${environment}/terraform-params/gitlab-server.tfvars \
			${environment}/terraform-configs
