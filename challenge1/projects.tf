module "web_application_project" {
  source              = "terraform-google-modules/project-factory/google//modules/fabric-project"
  version             = "11.2.3"
  parent              = var.parent_uri
  billing_account     = var.billing_account
  prefix              = var.project_prefix
  name                = var.project_name
  auto_create_network = false
  oslogin             = true
}

