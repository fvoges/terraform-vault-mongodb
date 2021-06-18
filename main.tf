

resource "vault_database_secret_backend_role" "role" {
  backend             = vault_mount.db.path
  name                = "my-role"
  db_name             = vault_database_secret_backend_connection.mongodb.name
  creation_statements = ["{\"database_name\": \"admin\",\"roles\": [{\"databaseName\":\"admin\",\"roleName\":\"atlasAdmin\"}]}"]
}

data "vault_policy_document" "mongodb_user_policy" {
  rule {
    description  = "Read system health check"
    path         = "mongodb/creds/my-role"
    capabilities = ["read"]
  }
}

resource "vault_policy" "mongodb_user" {
  name   = "mongodb-user"
  policy = data.vault_policy_document.mongodb_user_policy.hcl
}
