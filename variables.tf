variable "authorized_networks" {
  type = list(object({
    name            = string
    network         = string
    expiration_time = optional(string)
  }))
  default = []
}

variable "backup_config" {
  type = object({
    enabled                        = optional(bool, var.highly_available)
    start_time                     = optional(string)
    point_in_time_recovery_enabled = optional(bool, false)
    location                       = optional(string, "eu")
    transaction_log_retention_days = optional(number, 7)
    retained_backups               = optional(number, 7)
  })
  default = {}
}

variable "database_version" {
  type = string
}

variable "databases" {
  type = list(string)
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "environment" {
  type = string
  validation {
    condition     = contains(["production", "staging"], var.environment)
    error_message = "Environment must be production or staging."
  }
}

variable "flags" {
  type    = map(string)
  default = {}
}

variable "highly_available" {
  type = bool
}

variable "instance_name" {
  type = string
}

variable "insights_config" {
  type = object({
    query_insights_enabled  = bool
    query_string_length     = optional(number, 1024)
    record_application_tags = optional(bool, false)
    record_client_address   = optional(bool, false)
  })
  default = {
    query_insights_enabled = true
  }
}

variable "ipv4_enabled" {
  type    = bool
  default = true
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "maintenance_window" {
  type = object({
    day          = number
    hour         = number
    update_track = optional(string)
  })
  default = {
    day          = 1
    hour         = 4
    update_track = "stable"
  }
}

variable "primary_instance_name" {
  type    = string
  default = null
}

variable "private_network" {
  type    = string
  default = null
}

variable "storage_autoresize" {
  type = bool
}

variable "storage_limit" {
  type    = number
  default = 0
}

variable "storage_size" {
  type    = number
  default = 0
}

variable "tier" {
  type    = string
  default = null
}
