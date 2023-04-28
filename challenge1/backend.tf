terraform {
  backend "gcs" {
    bucket = "bkt-tf-state"
    prefix = "backend"
  }
}