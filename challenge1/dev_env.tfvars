region = "us-east4"
zone = "us-east4-c"
location = "US"

#project 

parent_uri = "organizations/11111XXXX000"
billing_account = "090XXXXXX"
project_prefix = "tier3"
project_name = "web-application"

#cloud nat 
cloud_nat_name = "nat-web-app"
min_ports_per_vm = 64
cloud_router_name = "router-web-app"

#cloud SQL 
application_server_db_name = "sql-webapp"
application_server_db_version = "MYSQL_8_0"

application_server_db_machine_type = "db-n1-standard-2"
application_server_availibility_type "ZONAL"
if_disk_autoresize = true
app_server_db_size_gb = 110
app_server_db_disk_type = "PD_SSD"
app_server_maintaince_day = 7
app_server_db_maintaince_window_update_track = "stable"
app_server_database_flags = 
database_flags = [
     {
     name  = "general_log"
     value = "on"
     },
     {
       name  = "log_output"
       value = "FILE"
     },
]
if_deletion_protection = true
app_server_db_backup_configuration = {
   enabled                        = true
   binary_log_enabled             = true
   start_time                     = "17:00"
   location                       = "US"
   transaction_log_retention_days = "7"
   retained_backups               = 90
   retention_unit                 = "COUNT"
   }

#instance template 

disk_size_gb = 100
machine_type = "n1-standard-8"
instance_template_name_prefix = "webserver-template"
application_webserver_sa = "sa-webserver@iam.gserviceaccounts.com"
instance_source_image = "debian-10-buster-v2092"
instance_source_image_project = "debian-cloud"
instance_source_image_family = "debian-10"
instance_network_tags = [
     "egress-allow-http-https",
     ]
instance_metadata ={
   block-project-ssh-keys = true
  }
if_enable_shielded_vm = true 
subnetwork_name = "sb-webserver"

#load balancer

internal_ilb = "ilb"
internal_ilb_source_ip_ranges = ["172.XX.XX.XX/20"]
internal_ilb_target_tags = ["nt-ingress"]
internal_ilb_ports = [ "3306","2290"]
internal_ilb_health_check = {
    "type"               : "tcp",
 "check_interval_sec" : 30,
 "healthy_threshold"  : 2,
 "timeout_sec"        : 10,
 "unhealthy_threshold": 2
 "response"           : "",
 "proxy_header"       : "NONE",
 "port"               : 3306,
 "port_name"          : "health-check-port",
 "request"            : "",
 "request_path"       : "/",
 "host"               : "",
 "enable_log"         : true
}
internal_ilb_backends=  [
   {
      group = "group-name-mig", failover = false
    }
internal_ilb_static_ip = 10.77.XX.XX/22
network_name = "vpc-webserver"

external_lb_name = "ext"
external_lb_target_tags = [ "nt-ingress"]
external_lb_backends = [ {
    group = "group-id"
}]

#managed instance groups

mig_application_webserver_name = "mig-websever"
mig_application_server_name = "mig-appserver"
mig_application_webserver_autoscaler_name = "mig-web-autoacaler"
mig_application_server_autoscaler_name = "mig-app-autoscaler"
mig_application_webserver_hostname = "mig"
mig_application_server_hostname ="mig"
if_autoscaling_enabled = true
autoscaling_cpu= [
   {
     target = 0.8
    }
  ]
app_webserver_autoscaling_scale_in_control = {
   "fixed_replicas"  : 1,    # Specifies the fixed number of VM instances
     "percent_replicas": null,
   "time_window_sec" : 600 # 10 min - How long the autoscaling should look when computing information for a new instance
   }
app_server_autoscaling_scale_in_control = {
   "fixed_replicas"  : 1,    # Specifies the fixed number of VM instances
     "percent_replicas": null,
   "time_window_sec" : 600 # 10 min - How long the autoscaling should look when computing information for a new instance
   }
cooldown_period = 120
webserver_min_replicas =3
app_server_min_replicas = 3
webserver_max_replicas = 4
app_server_max_replicas = 4
webserver_health_check_name = "web-health-check"
app_server_health_check_name = "app-health-check"
webserver_mig_health_check =  {
     "check_interval_sec" : 30,
     "healthy_threshold"  : 2,
     "host"               : "",
     "initial_delay_sec"  : 30,
     "port"               : 330909,
     "proxy_header"       : "NONE",
     "request"            : "",
     "request_path"       : "/",
     "response"           : "",
     "timeout_sec"        : 10,
     "type"               : "tcp",
     "unhealthy_threshold": 2
   }
app_server_mig_health_check =  {
     "check_interval_sec" : 30,
     "healthy_threshold"  : 2,
     "host"               : "",
     "initial_delay_sec"  : 30,
     "port"               : 330909,
     "proxy_header"       : "NONE",
     "request"            : "",
     "request_path"       : "/",
     "response"           : "",
     "timeout_sec"        : 10,
     "type"               : "tcp",
     "unhealthy_threshold": 2
   }

#secret manager 
app_server_db_root_secret_id = "secret-id-webserver"
app_server_db_root_secret_replication_locations = ["us-centra1" , "us-east4"]


#service accounts
web_application_sa_prefix = "sa-web"
web_application_sa_names = "webserver"
web_application_sa_roles_project_level = []

#vpc and subnets 

standalone_vpc = "standalone-vpc"
standalone_vpc_routing_mode = "REGIONAL"
us_east4_subnet_name = "sb-subnet-1-useast4"
us_central1_subnet_name =  "sb-subnet-1-uscentral"
us_east4_ip_range = "10.XX.XX.XX/20"
us_central1_ip_range = "10.XX.XX.XX/20"
us_east4_region = "us-east4"
us_central1_region = "us-central1"