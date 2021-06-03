locals {
  default_backup_config = {
    binary_log_enabled = var.highly_available == true ? true : false
    enabled            = var.highly_available == true ? true : false
    location           = "eu"
  }
  default_labels = {
    env = var.environment
  }
  default_tier = var.environment == "production" ? "db-custom-2-8192" : "db-f1-micro"

  backup_config = defaults(var.backup_config, local.default_backup_config)
  labels        = merge(local.default_labels, var.labels)
  storage_size  = var.storage_autoresize == true ? null : var.storage_size
  tier          = var.tier != null ? var.tier : local.default_tier
  users         = { for user in var.users : "${user.name}@${user.host}" => user }
}
