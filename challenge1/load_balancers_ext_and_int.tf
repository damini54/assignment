module "internal_ilb" {
  source           = "GoogleCloudPlatform/lb-internal/google"
  version          = "4.5.0"
  project          = module.web_application_project.project_id
  region           = var.region
  name             = var.internal_ilb
  source_ip_ranges = var.internal_ilb_source_ip_ranges
  source_tags      = []
  target_tags      = var.internal_ilb_target_tags
  ports            = var.internal_ilb_ports
  health_check     = var.internal_ilb_health_check
  backends = var.internal_ilb_backends
  ip_address                   = var.internal_ilb_static_ip
  ip_protocol                  = "TCP"
  create_backend_firewall      = false
  create_health_check_firewall = false
  network                      = var.network_name
  subnetwork                   = var.subnetwork_name
  network_project              = module.web_application_project.project_id
}


module "lb_external_http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  version           = "~> 4.4"
  project           = module.web_application_project.project_id
  name              = var.external_lb_name
  target_tags       = var.external_lb_target_tags
  backends          = var.external_lb_backends
}

