output "connection_name" {
  value = google_sql_database_instance.instance.connection_name
}

output "ip_addresses" {
  value = {
    for addr in google_sql_database_instance.instance.ip_address : addr.type => addr.ip_address
  }
}

output "admin_user_password" {
  sensitive = true
  value     = random_password.admin_user.result
}
