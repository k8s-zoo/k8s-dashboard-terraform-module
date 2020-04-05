TESTS_PATH:="test"
TEST_COMMONS_VAR_FILE:="test/commons.tfvars"
# kubernetes-dashboard
TEST_K8S_DASHBOARD:="test/kubernetes-dashboard"

validate:
	terraform init $(TEST_K8S_DASHBOARD) && terraform validate $(TEST_K8S_DASHBOARD)

deploy-k8s-dashboard:
	terraform init $(TEST_K8S_DASHBOARD)
	terraform apply -state=$(TEST_K8S_DASHBOARD)/terraform.tfstate -var-file=$(TEST_COMMONS_VAR_FILE) --auto-approve $(TEST_K8S_DASHBOARD)

destroy-k8s-dashboard:
	terraform init $(TEST_K8S_DASHBOARD)
	terraform destroy -state=$(TEST_K8S_DASHBOARD)/terraform.tfstate -var-file=$(TEST_COMMONS_VAR_FILE)  --auto-approve $(TEST_K8S_DASHBOARD)