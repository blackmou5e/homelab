resource "gitlab_group" "auth" {
  name                              = "auth"
  path                              = "auth"
  description                       = "Group for k8s access groups"
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

resource "gitlab_group" "admin" {
  name                              = "admin"
  path                              = "admin"
  parent_id                         = gitlab_group.auth.id
  description                       = "Group granting admin access rights to k8s"
  require_two_factor_authentication = false
  two_factor_grace_period           = 48
  prevent_forking_outside_group     = false
  project_creation_level            = "maintainer"
  subgroup_creation_level           = "maintainer"
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

resource "gitlab_group" "developer" {
  name                              = "developer"
  path                              = "developer"
  parent_id                         = gitlab_group.auth.id
  description                       = "Group granting developer access rights to k8s"
  require_two_factor_authentication = false
  two_factor_grace_period           = 48
  prevent_forking_outside_group     = false
  project_creation_level            = "maintainer"
  subgroup_creation_level           = "maintainer"
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
