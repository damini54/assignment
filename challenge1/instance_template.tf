data "template_file" "app_webserver"{
  template = file("../scripts/app_webserver.tpl")
}

module "vm_template_application_webserver"{
  source          = "terraform-google-modules/vm/google//modules/instance_template"
  version = "7.7.0"
  project_id      = module.web_application_project.project_id
  labels          = {}
  disk_size_gb    = var.disk_size_gb
  machine_type    = var.machine_type
  name_prefix     = var.instance_template_name_prefix
  service_account = {
    email  = var.application_webserver_sa
    scopes = ["cloud-platform"]
  }
  source_image         = var.instance_source_image 
  source_image_project = var.instance_source_image_project
  source_image_family  = var.instance_source_image_family
  tags                 = var.instance_network_tags
  region   = var.region
  metadata = var.instance_metadata
  enable_shielded_vm = var.if_enable_shielded_vm
  subnetwork_project = module.web_application_project.project_id
  subnetwork         = var.subnetwork_name
  startup_script     = data.template_file.app_webserver.rendered
}


