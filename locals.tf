locals {

  default_labels = {
    env = var.environment
  }
  default_tier = var.environment == "production" ? "db-custom-2-8192" : "db-f1-micro"

  labels       = merge(local.default_labels, var.labels)
  storage_size = var.storage_autoresize == true ? null : var.storage_size
  tier         = var.tier != null ? var.tier : local.default_tier

  admin_user = "postgres"

  # Helper vars for optional blocks. Will either be an empty set (no) or a
  # single item set (yes)
  needs_maintenance_window = var.primary_instance_name == null ? [0] : []
}
