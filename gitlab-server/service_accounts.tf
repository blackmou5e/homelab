resource "gitlab_user" "service_accounts" {
  for_each = {
    "docker"  = { "email" = "docker@example.com", "name" = "docker" }
    "cleanup" = { "email" = "cleanup@example.com", "name" = "cleanup" }
  }

  username         = each.key
  email            = each.value.email
  name             = each.value.name
  note             = "This user is managed by terraform"
  reset_password   = true
  is_admin         = false
  is_external      = false
  can_create_group = true
  state            = "active"

}

resource "gitlab_group_membership" "infra_service_accounts" {
  for_each = gitlab_user.service_accounts

  group_id     = gitlab_group.infra.id
  user_id      = each.value.id
  access_level = "maintainer"
}
