locals {
  default_backup_config = {
    enabled  = var.highly_available == true ? true : false
    location = "eu"
  }
  default_insights_config = {
    query_string_length     = 1024
    record_application_tags = false
    record_client_address   = false
  }
  default_labels = {
    env = var.environment
  }
  default_tier = var.environment == "production" ? "db-custom-2-8192" : "db-f1-micro"

  backup_config   = defaults(var.backup_config, local.default_backup_config)
  insights_config = defaults(var.insights_config, local.default_insights_config)

  labels       = merge(local.default_labels, var.labels)
  storage_size = var.storage_autoresize == true ? null : var.storage_size
  tier         = var.tier != null ? var.tier : local.default_tier

  admin_user = "postgres"

  # Helper vars for optional blocks. Will either be an empty set (no) or a
  # single item set (yes)
  needs_backup_retention_settings = local.backup_config.retained_backups == null ? [] : [0]
  needs_maintenance_window        = var.primary_instance_name == null ? [] : [0]
}
