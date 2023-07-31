variable "project_id" {
  type = string
  description = "Project ID in which secret is to be created"
}

variable "secret_id"{
  type = string
  description = "Secret ID"
}

variable "labels"{
  type = map(string)
  description = "Labels"
  default = {}
}

variable "replication_locations"{
  type = list(string)
  description = "Location list in which secret needs to be replicated"
  default = []
}