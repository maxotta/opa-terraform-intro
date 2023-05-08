from opa_client.opa import OpaClient
import json
import pprint as pp

client = OpaClient() 

result = client.check_connection()
print("Result:" + result)

#client.delete_opa_policy("datastore")
result = client.update_opa_policy_fromfile("terraform_4.rego", endpoint="terraform")

result = client.get_policies_list()
print("Policy list:" + str(result))

# result = client.get_opa_policy("terraform")
# print("Policy:" + str(result))

tf_plan = open("terraform-plan.json", "r")
input_data = json.load(tf_plan)
tf_plan.close()
# print("Input data:" + str(input_data))


result = client.check_policy_rule(input_data, "terraform") #, "uses_datastore_101")
print("Policy check result:")
pp.pprint(result)

client.close_connection()

# EOF
