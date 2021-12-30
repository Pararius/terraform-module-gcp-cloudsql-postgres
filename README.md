Terraform module to manage postgres CloudSQL instances.

# Usage

Primary instance example

```
module "db" {
  source = "github.com/Pararius/terraform-module-gcp-cloudsql-postgres.git"

  authorized_networks = [
    {
      name    = "Office"
      network = "<office-cidr>"
    }
  ]
  backup_config = {
    enabled = true
    location = "eu"
  }
  database_version = "POSTGRES_13"
  databases        = ["db1", "db2"]
  environment      = "production"
  highly_available = true
  instance_name    = "my-db-instance"
  labels           = { "env" = "production" }
  storage_limit    = 150
  storage_size     = 50
  tier             = "db-custom-2-8192"
}
```

Replica instance example

```
module "replica" {
  source = "github.com/Pararius/terraform-module-gcp-cloudsql-postgres.git"

  database_version      = "POSTGRES_13"
  deletion_protection   = false
  environment           = "staging"
  highly_available      = false
  instance_name         = "my-replica-instance"
  primary_instance_name = "my-primary-instance"
  storage_autoresize    = true
  tier                  = "db-custom-2-8192"
}
```

# Remarks

This module intentionally does not support creating database users. The only
user that is created, is the postgres admin user.
