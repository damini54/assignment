module "cloud_nat" {
  source                              = "terraform-google-modules/cloud-nat/google"
  version                             = "2.2.1"
  name                                = var.cloud_nat_name
  project_id                          = module.web_application_project.project_id
  region                              = var.region
  router                              = module.cloud_router_nat.router.name
  min_ports_per_vm                    = var.min_ports_per_vm
  source_subnetwork_ip_ranges_to_nat  = var.source_subnetwork_ip_ranges_to_nat
  enable_endpoint_independent_mapping = false
  nat_ips                             = module.cloud_nat_external_static_ip_reserve.self_links
}

module "cloud_nat_external_static_ip_reserve" {
  source       = "terraform-google-modules/address/google"
  version      = "3.1.1"
  project_id   = module.web_application_project.project_id
  region       = var.region
  address_type = "EXTERNAL"
  names = [
    "nat-us-east4-1",
    "nat-us-east4-2",
    "nat-us-east4-3"
  ]
  enable_cloud_dns = false
}

module "cloud_router_nat" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "3.0.0"
  name    = var.cloud_router_name
  project = module.web_application_project.project_id
  region  = var.region
  network = module.standalone_vpc.network_name
}

