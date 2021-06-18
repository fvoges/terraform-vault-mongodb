resource "vault_mount" "db" {
  path = "mongodb"
  type = "database"
}

resource "vault_database_secret_backend_connection" "mongodb" {
  backend       = vault_mount.db.path
  name          = "mongodb"
  allowed_roles = ["my-role"]

  mongodbatlas {
    public_key  = var.mongodb_public_key
    private_key = var.mongodb_private_key
    project_id  = var.mongodb_project_id
  }
}