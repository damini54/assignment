module "sql_app_server_db" {
  source           = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version          = "10.0.1"
  project_id       = module.web_application_project.project_id
  name             = var.application_server_db_name
  database_version = var.application_server_db_version
  region = var.region
  zone   = var.zone

  tier              = var.application_server_db_machine_type
  availability_type = var.application_server_availibility_type
  disk_autoresize = var.if_disk_autoresize
  disk_size       = var.app_server_db_size_gb
  disk_type       = var.app_server_db_disk_type
  maintenance_window_day          = var.app_server_maintaince_day
  maintenance_window_update_track = var.app_server_db_maintaince_window_update_track
  database_flags = var.app_server_database_flags
  deletion_protection = var.if_deletion_protection
  backup_configuration = var.app_server_db_backup_configuration
  ip_configuration = {
    ipv4_enabled        = false
    require_ssl         = true
    private_network     = module.standalone_vpc.self_link
    authorized_networks = []
    allocated_ip_range = null
  }
  user_name     = "root"
  user_password = data.google_secret_manager_secret_version.app_server_db_root_pwd.secret_data
}


data "google_secret_manager_secret_version" "app_server_db_root_pwd"{
  secret = module.app_server_db_root_pwd.secret_id
}

