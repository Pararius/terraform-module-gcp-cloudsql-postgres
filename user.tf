resource "random_password" "admin_user" {
  length = 48
}

resource "google_sql_user" "admin_user" {
  instance = google_sql_database_instance.instance.name

  name     = local.admin_user
  password = random_password.admin_user.result
  type     = "" # Equivalent of "BUILT_IN"

  deletion_policy = null
}

resource "random_password" "migrated_users" {
  for_each = toset(var.migrated_users)
  length   = 48
}

resource "google_sql_user" "migrated_users" {
  for_each = toset(var.migrated_users)

  instance        = google_sql_database_instance.instance.name
  name            = each.value
  password        = random_password.migrated_users[each.value].result
  type            = ""
  deletion_policy = null
}
