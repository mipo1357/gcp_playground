resource "google_sql_database_instance" "postgres" {
  name             = "cloudrun-sql"
  region           = var.location
  database_version = "POSTGRES_13"
  settings {
    tier = "db-f1-micro"
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }

  deletion_protection = "false"
}

resource "google_sql_database" "database" {
  name     = "quickstart_db"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "users" {
  name     = "quickstart-user"
  instance = google_sql_database_instance.postgres.name
  type     = "BUILT_IN"
  password = var.db_user_password
}

resource "google_sql_user" "root_user" {
  name     = "postgres"
  instance = google_sql_database_instance.postgres.name
  type     = "BUILT_IN"
  password = var.db_root_user_password
}
