variable "authorized_networks" {
  type = list(object({
    name    = string
    network = string
  }))
  default = []
}

variable "backup_config" {
  type = object({
    enabled                        = optional(bool)
    start_time                     = optional(string)
    point_in_time_recovery_enabled = optional(bool)
    location                       = optional(string)
    transaction_log_retention_days = optional(number)
    retained_backups               = optional(number)
  })
  default = {
    enabled = false
  }
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
    query_string_length     = optional(number)
    record_application_tags = optional(bool)
    record_client_address   = optional(bool)
  })
  default = null
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "primary_instance_name" {
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
