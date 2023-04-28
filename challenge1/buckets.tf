module "bkt_webserver_images" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "3.2.0"
  name       = var.bkt_webserver_images_name
  project_id = module.web_application_project.project_id
  location   = var.location
  versioning = var.if_versioning_to_be_enabled
  bucket_policy_only = true
  storage_class = "STANDARD"
  iam_members = var.bkt_webserver_images_bucket_iam
}

