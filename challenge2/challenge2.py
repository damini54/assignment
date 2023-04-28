import json
from google.cloud import compute_v1
from google.cloud.compute_v1.types import GetInstanceRequest
from google.protobuf.json_format import MessageToDict
def get_vm_metadata(name, project_id, zone, key= None):
    instance_client = compute_v1.InstancesClient()
    request = GetInstanceRequest(instance=name,zone= zone, project = project_id)

    vm_data = MessageToDict(instance_client.get(request=request)._pb)
    if key:
        return vm_data.get(key,"Error: provide a valid key")
    return vm_data

if __name__ == "__main__":
    print(get_vm_metadata(name = "challenge2-vm",project_id = "challenge2-project-id",zone = "us-east4-c",key="a"))