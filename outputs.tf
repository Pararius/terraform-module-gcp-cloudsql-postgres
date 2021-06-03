output "passwords" {
  sensitive = true
  value     = { for user, pwd in random_password.sql_user : user => pwd.result }
}
