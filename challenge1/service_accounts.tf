module "sa_application_webserver"{
  source     = "terraform-google-modules/service-accounts/google"
  version    = "4.1.1"
  project_id = module.web_application_project.project_id
  prefix     = var.web_application_sa_prefix
  names      = var.web_application_sa_names
  project_roles = var.web_application_sa_roles_project_level
}

