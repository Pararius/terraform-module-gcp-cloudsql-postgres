locals {
  default_backup_config = {
    enabled  = var.highly_available == true ? true : false
    location = "eu"
  }
  default_labels = {
    env = var.environment
  }
  default_tier = var.environment == "production" ? "db-custom-2-8192" : "db-f1-micro"

  backup_config = defaults(var.backup_config, local.default_backup_config)
  labels        = merge(local.default_labels, var.labels)
  storage_size  = var.storage_autoresize == true ? null : var.storage_size
  tier          = var.tier != null ? var.tier : local.default_tier

  postgres_users = local.db_engine != { for user in concat(var.users, [{ name = "postgres" }]) : user.name => user }
}
