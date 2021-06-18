resource "vault_identity_group" "mongodbuser" {
  name     = var.mongodb_users_groupname
  type     = "external"
  metadata = var.mongodb_users_metadata
  policies = [vault_policy.mongodb_user.name]
}

resource "vault_identity_group_alias" "default" {
  name           = var.oidc_group_alias_name
  mount_accessor = var.oidc_mount_accessor
  canonical_id   = vault_identity_group.mongodbuser.id
}
