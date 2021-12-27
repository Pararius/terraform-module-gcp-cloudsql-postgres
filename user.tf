resource "random_password" "sql_user" {
  local.postgres_users

  length = 48
}

resource "google_sql_user" "postgres_user" {
  for_each = local.postgres_users

  instance = google_sql_database_instance.instance.name
  name     = each.value.name
  password = random_password.sql_user[each.key].result
}
