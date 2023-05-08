package terraform

# Check whether the OS image will be stored on the correct datastore
deny[reason] {
	r := input.resource_changes[_]
	r.type == "opennebula_image"
	r.change.after.datastore_id != 101
	reason := sprintf("Wrong datastore ID for OS image '%s'", [r.change.after.name])
}

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

# Check that at least 2 instances of "test-node-vm" are created

is_test_node_vm(r) {
    r.type == "opennebula_virtual_machine"
    r.name == "test-node-vm"
}

deny[reason] {
    # This is a "list comprehension" - create a list based on another list
    #
    test_nodes := [r | r := input.resource_changes[_]; is_test_node_vm(r)]
    cnt := count(test_nodes)
    
    cnt < 4

    reason := sprintf("Insufficient number of test nodes: %d", [cnt])
}