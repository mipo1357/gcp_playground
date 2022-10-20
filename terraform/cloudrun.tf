resource "google_cloud_run_service" "default" {
  name                       = "run-sql"
  location                   = var.location
  autogenerate_revision_name = true

  template {
    spec {
      containers {
        image = var.container_image
        env {
          name  = "INSTANCE_UNIX_SOCKET"
          value = "/cloudsql/${var.project}:${var.location}:${google_sql_database_instance.postgres.name}"
        }
        env {
          name  = "DB_NAME"
          value = google_sql_database.database.name
        }
        env {
          name  = "DB_USER"
          value = google_sql_user.users.name
        }
        env {
          name  = "DB_PASS"
          value = google_sql_user.users.password
        }
        env {
          name  = "DB_IAM_USER"
          value = "${google_service_account.github_actions.name}@${var.project}.iam"
        }
      }
      service_account_name = google_service_account.github_actions.email
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1000"
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.postgres.connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
  }
}

output "url" {
  value = google_cloud_run_service.default.status[0].url
}
