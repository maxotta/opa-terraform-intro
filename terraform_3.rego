package terraform

# Disk size too small
deny[reason] {
	r := input.resource_changes[_]
	d := input.resource_changes[i].change.after.disk[j]
	machine_name := input.resource_changes[i].change.after.name

	r.type == "opennebula_virtual_machine"
	d.target == "vda"
	d.size < 12000

	reason := sprintf("Disk size too small on %s", [machine_name])
}

# Disk size too large
deny[reason] {
	r := input.resource_changes[_]
	d := input.resource_changes[i].change.after.disk[j]
	machine_name := input.resource_changes[i].change.after.name

	r.type == "opennebula_virtual_machine"
	d.target == "vda"
	d.size > 20000

	reason := sprintf("Disk size too large on %s", [machine_name])
}
