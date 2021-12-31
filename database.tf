resource "google_sql_database" "database" {
  for_each = toset(var.databases)

  instance = google_sql_database_instance.instance.name
  name     = each.value

  charset   = "UTF8"
  collation = "en_US.UTF8"
}
