module "app_server_db_root_pwd" {
  source                = "../custom_modules/secret_manager"
  secret_id             = var.app_server_db_root_secret_id
  project_id            = module.web_application_project.project_id
  replication_locations = var.app_server_db_root_secret_replication_locations
}

