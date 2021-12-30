resource "google_sql_database_instance" "instance" {
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  name                = var.instance_name

  master_instance_name = var.primary_instance_name

  settings {
    availability_type = var.highly_available == true ? "REGIONAL" : "ZONAL"

    disk_autoresize       = var.storage_autoresize
    disk_autoresize_limit = var.storage_limit
    disk_size             = local.storage_size
    disk_type             = "PD_SSD"

    tier        = local.tier
    user_labels = local.labels

    backup_configuration {
      enabled  = local.backup_config.enabled
      location = local.backup_config.location
    }

    dynamic "database_flags" {
      for_each = var.flags
      iterator = flag
      content {
        name  = flag.key
        value = flag.value
      }
    }

    dynamic "ip_configuration" {
      for_each = local.externally_accessible == true ? [0] : []
      content {
        ipv4_enabled = true
        require_ssl  = true

        dynamic "authorized_networks" {
          for_each = var.authorized_networks
          iterator = network

          content {
            name  = network.value.name
            value = network.value.network
          }
        }
      }
    }

    dynamic "maintenance_window" {
      for_each = var.primary_instance_name == null ? [0] : []
      content {
        day  = 1
        hour = 4
      }
    }
  }
}
