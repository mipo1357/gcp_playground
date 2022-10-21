variable "project" {
  description = "A name of a GCP project"
  type        = string
  default     = null
}

variable "location" {
  description = "A location of a cloud run instance"
  type        = string
  default     = "asia-northeast1"
}

variable "repo_name" {
  description = "github repository name"
  default     = "user/repository"
}

variable "container_image" {
  description = "docker container image"
  type        = string
  default     = ""
}

variable "db_user_password" {
  description = "password for the builtin mysql user"
  default     = ""
}

variable "db_root_user_password" {
  description = "password for the root mysql user"
  default     = ""
}

variable "workload_identity_pool_name" {
  description = "name of workload identity pool"
  default     = ""
}
