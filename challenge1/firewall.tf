module "firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  version                 = "5.1.0"
  project_id              = module.web_application_project.project_id
  network                 = module.standalone_vpc.network_name
  internal_ranges_enabled = false
  internal_ranges         = []
  internal_target_tags    = []
  ssh_source_ranges       = []
  ssh_target_tags         = []
  https_target_tags       = []
  https_source_ranges     = []
  http_source_ranges      = []
  custom_rules = {
    fw-65000-egress-deny-all = {
      description          = "Override default allow all ports egress rule"
      direction            = "EGRESS"
      action               = "deny"
      ranges               = ["X.X.X"]
      use_service_accounts = false
      rules = [
        {
          protocol = "all"
          ports    = []
        }
      ]
      sources = []
      targets = []
      extra_attributes = {
        priority           = 65000
        flow_logs          = true
        flow_logs_metadata = "INCLUDE_ALL_METADATA"
      }
    }

    fw-egress-allow-all = {
      description          = "Allows for internal VPC communication"
      direction            = "EGRESS"
      action               = "allow"
      ranges               = [X.X.X.X/X]
      use_service_accounts = false
      rules = [
        {
          protocol = "all"
          ports    = []
        }
      ]
      sources = []
      targets = []
      extra_attributes = {
        priority           = 1000
        flow_logs          = true
        flow_logs_metadata = "INCLUDE_ALL_METADATA"
      }
    }

    fw-egress-allow-all-onprem-ssh-icmp-dns = {
      description = "Allows all ssh, icmp and dns traffic to onprem"
      direction   = "EGRESS"
      action      = "allow"
      ranges = []
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = ["22", "53"]
        },
        {
          protocol = "icmp"
          ports    = []
        },
      ]
      sources = []
      targets = []
      extra_attributes = {
        priority           = 1000
        flow_logs          = true
        flow_logs_metadata = "INCLUDE_ALL_METADATA"
      }
    }
}