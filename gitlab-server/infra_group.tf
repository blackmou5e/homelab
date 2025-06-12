resource "gitlab_group" "infra" {
  name                              = "infra"
  path                              = "infra"
  description                       = "Group for infrastructure components"
  require_two_factor_authentication = false
  two_factor_grace_period           = 48
  project_creation_level            = "maintainer"
  subgroup_creation_level           = "maintainer"
  prevent_forking_outside_group     = false
  shared_runners_setting            = "disabled_and_unoverridable"
  auto_devops_enabled               = false
  emails_enabled                    = false
  lfs_enabled                       = false
  membership_lock                   = false
  mentions_disabled                 = true
  request_access_enabled            = true
  share_with_group_lock             = true
  visibility_level                  = "internal"
}
