# ------------------------------------------------------- #
#                Run AVD With Various Tags                #
# ------------------------------------------------------- #

.PHONY: help
help: ## Display help message (*: main entry points / []: part of an entry point)
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# ------------------------------------------------------- #
#                         Build                           #
# ------------------------------------------------------- #

.PHONY: build_all
build_all: ## Build AVD configs for all campuses
				ansible-playbook playbooks/fabric_deploy.yml --tags build

.PHONY: build_campus_a
build_campus_a: ## Build AVD configs for CAMPUS_A
				ansible-playbook playbooks/fabric_deploy.yml --tags build --limit CAMPUS_A

.PHONY: build_campus_b
build_campus_b: ## Build AVD configs for CAMPUS_B
				ansible-playbook playbooks/fabric_deploy.yml --tags build --limit CAMPUS_B

.PHONY: build_campus_c
build_campus_c: ## Build AVD configs for CAMPUS_C
				ansible-playbook playbooks/fabric_deploy.yml --tags build --limit CAMPUS_C

# ------------------------------------------------------- #
#                         Deploy                          #
# ------------------------------------------------------- #

.PHONY: deploy_all
deploy_all: ## Build AVD configs for all campuses
				ansible-playbook playbooks/fabric_deploy.yml -i inventory/inventory.yml

.PHONY: deploy_campus_a_cvp
deploy_campus_a_cvp: ## Deploy CAMPUS_A AVD configs through CVP
				ansible-playbook playbooks/fabric_deploy.yml -i inventory/inventory.yml --limit CAMPUS_A

.PHONY: deploy_campus_b_cvp
deploy_campus_b_cvp: ## Deploy CAMPUS_B AVD configs through CVP
				ansible-playbook playbooks/fabric_deploy.yml -i inventory/inventory.yml --limit CAMPUS_B

.PHONY: deploy_campus_c_cvp
deploy_campus_c_cvp: ## Deploy CAMPUS_C AVD configs through CVP
				ansible-playbook playbooks/fabric_deploy.yml -i inventory/inventory.yml --limit CAMPUS_C

# .PHONY: deploy_cert
# deploy_cert: ## Deploy xyz.crt to switches
#         ansible-playbook playbooks/add_cert.yml -i inventory/inventory.yml

# .PHONY: gen_certs
# gen_certs: ## Generate certificates for SSL profiles
#         ansible-playbook playbooks/gen_certs.yml -i inventory/inventory.yml --limit CAMPUS_A-Leaf1A

# ------------------------------------------------------- #
#                       Validate                          #
# ------------------------------------------------------- #

.PHONY: validate_state_all
validate_state_all: ## Validate state of all campuses
				ansible-playbook playbooks/validate_state.yml -i inventory/act_inventory.yml --ask-vault-password

.PHONY: validate_state_campus_a
validate_state_campus_a: ## Validate state of CAMPUS_A
				ansible-playbook playbooks/validate_state.yml -i inventory/act_inventory.yml --ask-vault-password --limit CAMPUS_A

.PHONY: validate_state_campus_b
validate_state_campus_b: ## Validate state of CAMPUS_B
				ansible-playbook playbooks/validate_state.yml -i inventory/act_inventory.yml --ask-vault-password --limit CAMPUS_B

.PHONY: validate_state_campus_c
validate_state_campus_c: ## Validate state of CAMPUS_C
				ansible-playbook playbooks/validate_state.yml -i inventory/act_inventory.yml --ask-vault-password --limit CAMPUS_C
