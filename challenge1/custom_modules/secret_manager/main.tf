resource "google_secret_manager_secret" "secret" {
  project = var.project_id
  secret_id = var.secret_id
  labels = var.labels
  replication {
    dynamic "user_managed"{
      for_each = length(var.replication_locations) > 0 ? [1] : []
      content {
        dynamic "replicas" {
          for_each = var.replication_locations
          content {
            location = replicas.value
          }
        }
      }
    }
    automatic = length(var.replication_locations) > 0 ? null : true
  }
}