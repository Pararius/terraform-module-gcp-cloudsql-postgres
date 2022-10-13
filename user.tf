resource "random_password" "admin_user" {
  length = 48
}

resource "google_sql_user" "admin_user" {
  instance = google_sql_database_instance.instance.name

  name     = local.admin_user
  password = random_password.admin_user.result
  type     = "BUILT_IN"

  deletion_policy = null
}

resource "random_password" "legacy_users" {
  for_each = toset(var.legacy_users)
  length   = 48
}

resource "google_sql_user" "legacy_users" {
  for_each = toset(var.legacy_users)

  instance        = google_sql_database_instance.instance.name
  name            = each.value
  password        = random_password.legacy_users[each.value].result
  type            = "BUILT_IN"
  deletion_policy = null
}
