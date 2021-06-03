resource "random_password" "sql_user" {
  for_each = local.users

  length = 48
}

resource "google_sql_user" "sql_user" {
  for_each = local.users

  instance = google_sql_database_instance.instance.name
  name     = each.value.name
  host     = each.value.host
  password = random_password.sql_user[each.key].result
}
