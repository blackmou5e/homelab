resource "gitlab_user" "devops" {
  for_each = {
    "george.nikishin" = { "email" = "test@example.com", "name" = "George Nikishin" }
    //"admin2.user"     = { "email" = "test@test.ru", "name" = "Admin 2" }
  }

  username         = each.key
  email            = each.value.email
  name             = each.value.name
  note             = "This user is managed by terraform"
  reset_password   = true
  is_admin         = true
  is_external      = false
  can_create_group = true
  state            = "active"

}

resource "gitlab_group_membership" "infra_members" {
  for_each = gitlab_user.devops

  group_id     = gitlab_group.infra.id
  user_id      = each.value.id
  access_level = "maintainer"
}

resource "gitlab_group_membership" "dex_admin_access" {
  for_each = gitlab_user.devops

  group_id     = gitlab_group.admin.id
  user_id      = each.value.id
  access_level = "maintainer"
}
