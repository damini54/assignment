variable "region" {
    type = string
}
variable "zone" {
    type = string
}

#buckets
variable "bkt_webserver_images_name" {
    type = string
}
variable "location" {
    type = string
}
variable "if_versioning_to_be_enabled" {
    type = bool
}
variable "bkt_webserver_images_bucket_iam" {
  type = list(object({
    role   = string
    member = string
  }))
  default = []
}

#SQL database

variable "application_server_db_name" {
    type        = string
}
variable "application_server_db_version" {
    type        = string
}
variable "application_server_db_machine_type" {
    type        = string
}
variable "application_server_availibility_type" {
  type        = string

}
variable "if_disk_autoresize" {
  type        = bool
}
variable "app_server_db_size_gb" {
  type        = number
}
variable "app_server_db_disk_type" {
  type        = string
}
variable "app_server_maintaince_day" {
  type        = number
}
variable "app_server_db_maintaince_window_update_track" {
  type        = string
}
variable "app_server_database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
variable "if_deletion_protection" {
    type = bool
}
variable "app_server_db_backup_configuration" {
  type = object({
    binary_log_enabled             = bool
    enabled                        = bool
    start_time                     = string
    location                       = string
    transaction_log_retention_days = string
    retained_backups               = number
    retention_unit                 = string
  })
  default = {
    binary_log_enabled             = false
    enabled                        = false
    start_time                     = null
    location                       = null
    transaction_log_retention_days = null
    retained_backups               = null
    retention_unit                 = null
  }

}

#Instance Template 
variable "disk_size_gb" {
    type = string 
}
variable "machine_type" {
    type = string 
}
variable "instance_template_name_prefix" {
    type = string 
}
variable "application_webserver_sa" {
    type = string 
}
variable "instance_source_image" {
    type = string 
}
variable "instance_source_image_project" {
    type = string 
}
variable "instance_source_image_family" {
    type = string 
}
variable "instance_network_tags" {
  type   = list(string)
}
variable "instance_metadata" {
    type = string 
}
variable "if_enable_shielded_vm" {
    type = bool 
}
variable "subnetwork_name" {
    type = string 
}

#load balancers

variable "internal_ilb" {
    type = string 
}
variable "internal_ilb_source_ip_ranges" {
  type        = list(string)
}
variable "internal_ilb_target_tags" {
  type        = list(string)
}
variable "internal_ilb_ports" {
  type        = list(string)
}
variable "internal_ilb_health_check" {
  type = object({
    type                = string
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    port_name           = string
    request             = string
    request_path        = string
    host                = string
    enable_log          = bool
  })
}
variable "internal_ilb_backends" {
   type        = list(any)
}
variable "internal_ilb_static_ip" {
  default     = null
}
variable "network_name" {
    type = string 
}

variable "external_lb_name" {
    type = string 
}
variable "external_lb_target_tags" {
  type        = list(string)
}
variable "external_lb_backends" {
type = map(object({
    protocol  = string
    port      = number
    port_name = string

    description             = string
    enable_cdn              = bool
    security_policy         = string
    custom_request_headers  = list(string)
    custom_response_headers = list(string)

    timeout_sec                     = number
    connection_draining_timeout_sec = number
    session_affinity                = string
    affinity_cookie_ttl_sec         = number

    health_check = object({
      check_interval_sec  = number
      timeout_sec         = number
      healthy_threshold   = number
      unhealthy_threshold = number
      request_path        = string
      port                = number
      host                = string
      logging             = bool
    })

    log_config = object({
      enable      = bool
      sample_rate = number
    })

    groups = list(object({
      group = string

      balancing_mode               = string
      capacity_scaler              = number
      description                  = string
      max_connections              = number
      max_connections_per_instance = number
      max_connections_per_endpoint = number
      max_rate                     = number
      max_rate_per_instance        = number
      max_rate_per_endpoint        = number
      max_utilization              = number
    }))
    iap_config = object({
      enable               = bool
      oauth2_client_id     = string
      oauth2_client_secret = string
    })
  }))
}

#managed instance groups

variable "mig_application_webserver_name" {
    type        = string
}
variable "mig_application_server_name" {
  type        = string
}
variable "mig_application_webserver_autoscaler_name" {
  type        = string
}
variable "mig_application_server_autoscaler_name" {
  type        = string
}
variable "mig_application_webserver_hostname" {
  default     = "default"
}
variable "mig_application_server_hostname" {
  default     = "default"
}
variable "if_autoscaling_enabled" {

}
variable "autoscaling_cpu" {
  type        = list(map(number))
  default     = []
}
variable "app_webserver_autoscaling_scale_in_control" {
type = object({
    fixed_replicas   = number
    percent_replicas = number
    time_window_sec  = number
  })
  default = {
    fixed_replicas   = null
    percent_replicas = null
    time_window_sec  = null
  }
}
variable "app_server_autoscaling_scale_in_control" {
type = object({
    fixed_replicas   = number
    percent_replicas = number
    time_window_sec  = number
  })
  default = {
    fixed_replicas   = null
    percent_replicas = null
    time_window_sec  = null
  }
}
variable "cooldown_period" {
  default     = 60
}
variable "webserver_min_replicas" {
    type = number
}
variable "app_server_min_replicas" {
    type = number
}
variable "webserver_max_replicas" {
    type = number
}
variable "app_server_max_replicas" {
    type = number
}
variable "webserver_health_check_name" {
  type        = string
}
variable "app_server_health_check_name" {
  type        = string
}
variable "webserver_mig_health_check" {
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    request             = string
    request_path        = string
    host                = string
  })
  default = {
    type                = ""
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    host                = ""
  }
}
variable "app_server_mig_health_check" {
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    request             = string
    request_path        = string
    host                = string
  })
  default = {
    type                = ""
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    host                = ""
  }
}

# project

variable "parent_uri" {
    type = string
}
variable "billing_account" {
    type = string
}
variable "project_prefix" {
    type = string
}
variable "project_name" {
    type = string
}

#secret_manager

variable "app_server_db_root_secret_id" {
    type = string
}
variable "app_server_db_root_secret_replication_locations" {
    type = list(string)
}

#service accounts

variable "web_application_sa_prefix" {
    type = string
}
variable "web_application_sa_names" {
    type = string
}
variable "web_application_sa_roles_project_level" {
  type   = list(string)
  default = []
}

#vpc and subnets 

variable "standalone_vpc" {
    type = string
}
variable "standalone_vpc_routing_mode" {
    type = string
}
variable "us_east4_subnet_name" {
    type = string
}
variable "us_central1_subnet_name" {
    type = string
}
variable "us_east4_ip_range" {
    type = string
}
variable "us_central1_ip_range" {
    type = string
}
variable "us_east4_region" {
    type = string
}
variable "us_central1_region" {
    type = string
}

#cloud nat and router 

variable "cloud_nat_name" {
    type = string
}
variable "min_ports_per_vm" {
    type = number
}
variable "cloud_router_name" {
    type = string
}

variable "loactions" {
  type = string
}