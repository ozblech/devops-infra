init: 
	@terraform init -force-copy -get=true -input=false


plan:
	@terraform plan -input=true -refresh=true -var-file=environment/dev/dev.tfvars

apply:
	@terraform apply -input=true -refresh=true -var-file=environment/dev/dev.tfvars

destroy:
	@terraform destroy -var-file=environment/dev/dev.tfvars

apply-auto-approve:
	@terraform apply -input=false -auto-approve -refresh=true -var-file=environment/dev/dev.tfvars