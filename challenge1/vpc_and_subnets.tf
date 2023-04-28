module "standalone_vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "5.1.0"
  project_id   = module.web_application_project.project_id
  network_name = var.standalone_vpc
  routing_mode = var.standalone_vpc_routing_mode
  description  = "Terraform Managed VPC"
  subnets = [
    {
      subnet_name           = var.us_east4_subnet_name
      subnet_ip             = var.us_east4_ip_range
      subnet_region         = var.us_east4_region
      subnet_private_access = true
      subnet_flow_logs      = true
    },
    {
      subnet_name           = var.us_central1_subnet_name
      subnet_ip             = var.us_central1_ip_range
      subnet_region         = var.us_central1_region
      subnet_private_access = true
      subnet_flow_logs      = true
    },
  ]
}
