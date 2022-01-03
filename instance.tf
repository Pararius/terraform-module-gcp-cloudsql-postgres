resource "google_sql_database_instance" "instance" {
  database_version     = var.database_version
  name                 = var.instance_name
  deletion_protection  = var.deletion_protection
  master_instance_name = var.primary_instance_name

  settings {
    activation_policy     = "ALWAYS"
    availability_type     = var.highly_available == true ? "REGIONAL" : "ZONAL"
    disk_autoresize       = var.storage_autoresize
    disk_autoresize_limit = var.storage_limit
    disk_size             = local.storage_size
    disk_type             = "PD_SSD"
    pricing_plan          = "PER_USE"
    tier                  = local.tier
    user_labels           = local.labels

    backup_configuration {
      enabled                        = local.backup_config.enabled
      start_time                     = local.backup_config.start_time
      point_in_time_recovery_enabled = local.backup_config.point_in_time_recovery_enabled
      location                       = local.backup_config.location
      transaction_log_retention_days = local.backup_config.transaction_log_retention_days
      backup_retention_settings {
        retained_backups = local.backup_config.retained_backups
        retention_unit   = "COUNT"
      }
    }

    dynamic "database_flags" {
      for_each = var.flags
      iterator = flag

      content {
        name  = flag.key
        value = flag.value
      }
    }

    insights_config {
      query_insights_enabled  = local.insights_config.query_insights_enabled
      query_string_length     = local.insights_config.query_string_length
      record_application_tags = local.insights_config.record_application_tags
      record_client_address   = local.insights_config.record_client_address
    }

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.private_network

      require_ssl = true

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        iterator = network

        content {
          expiration_time = network.value.expiration_time
          name            = network.value.name
          value           = network.value.network
        }
      }
    }

    location_preference {
      follow_gae_application = null
      zone                   = null
    }

    dynamic "maintenance_window" {
      for_each = local.needs_maintenance_window

      content {
        day          = var.maintenance_window.day
        hour         = var.maintenance_window.hour
        update_track = lookup(var.maintenance_window, "update_track", "stable")
      }
    }
  }
}
