module "mig_application_webserver"{
  source              = "terraform-google-modules/vm/google//modules/mig"
  version             = "7.7.0"
  project_id          = module.web_application_project.project_id
  region              = var.region
  mig_name            = var.mig_application_webserver_name
  autoscaler_name     = var.mig_application_webserver_autoscaler_name
  hostname            = var.mig_application_webserver_hostname
  autoscaling_enabled = var.if_autoscaling_enabled
  autoscaling_cpu     = var.autoscaling_cpu
  autoscaling_scale_in_control = var.app_webserver_autoscaling_scale_in_control
  cooldown_period   = var.cooldown_period
  min_replicas      = var.webserver_min_replicas
  max_replicas      = var.webserver_max_replicas
  health_check_name = var.webserver_health_check_name
  health_check      = var.webserver_mig_health_check
  instance_template  = module.vm_template_application_webserver.self_link
   subnetwork         = var.subnetwork_name
  subnetwork_project = var.subnetwork_project_id
}

module "mig_application_server"{
  source              = "terraform-google-modules/vm/google//modules/mig"
  version             = "7.7.0"
  project_id          = module.web_application_project.project_id
  region              = var.region
  mig_name            = var.mig_application_server_name
  autoscaler_name     = var.mig_application_server_autoscaler_name
  hostname            = var.mig_application_server_hostname
  autoscaling_enabled = var.if_autoscaling_enabled
  autoscaling_cpu     = var.autoscaling_cpu
  autoscaling_scale_in_control = var.app_server_autoscaling_scale_in_control
  cooldown_period   = var.cooldown_period
  min_replicas      = var.app_server_min_replicas
  max_replicas      = var.app_server_max_replicas
  health_check_name = var.app_server_health_check_name
  health_check      = var.app_server_mig_health_check
  instance_template  = module.vm_template_application_server.self_link
  subnetwork         = var.subnetwork_name
  subnetwork_project = var.subnetwork_project_id
}

