package terraform

# default deny = false

deny {
	r := input.resource_changes[_]
	r.type == "opennebula_image"
	r.change.after.datastore_id != 101
}
