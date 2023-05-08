package terraform

# Check whether the OS image will be stored on the correct datastore
deny[reason] {
	r := input.resource_changes[_]
	r.type == "opennebula_image"
	r.change.after.datastore_id != 101
	reason := sprintf("Wrong datastore ID for OS image '%s'", [r.change.after.name])
}

# opa eval --format pretty --data terraform_1.rego -i step-03-plan.json data.terraform.uses_datastore_101
# opa eval --format pretty --data terraform_1.rego -i step-03-plan.json data.terraform