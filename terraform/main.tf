terraform {
  required_version = "~> 1.3.2"
  required_providers {
    google = ">= 4.41.0"
  }
  backend "gcs" {
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project
  region  = var.location
}

data "google_iam_policy" "cloud_run_public" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "policy" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.cloud_run_public.policy_data
}
