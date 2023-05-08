package terraform

# default deny = false

deny {
	r := input.resource_changes[_]
	r.type == "opennebula_image"
	r.change.after.datastore_id != 101
}

# opa eval --format pretty --data terraform_1.rego -i step-03-plan.json data.terraform.uses_datastore_101
# opa eval --format pretty --data terraform_1.rego -i step-03-plan.json data.terraform