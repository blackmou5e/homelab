resource "gitlab_project" "gitlab_terraform" {
  name                                             = "gitlab-terraform"
  path                                             = "gitlab-terraform"
  namespace_id                                     = gitlab_group.infra.id
  visibility_level                                 = "internal"
  description                                      = "Repo for storing user and groups terraform state"
  initialize_with_readme                           = false

  // Some basic sense
  allow_merge_on_skipped_pipeline                  = false
  only_allow_merge_if_all_discussions_are_resolved = true
  only_allow_merge_if_pipeline_succeeds            = true
  
  // Manual chores are bad, and making Jack not happy
  remove_source_branch_after_merge                 = true
  squash_option                                    = "default_on"
  archive_on_destroy                               = true
  archived                                         = false
  auto_cancel_pending_pipelines                    = "enabled"
  auto_devops_enabled                              = false
  build_timeout                                    = 3600
  ci_delete_pipelines_in_seconds                   = 604800 //delete pipelines older than 1 week
  default_branch                                   = "main"
  emails_enabled                                   = false
  lfs_enabled                                      = false

  //don't even ask, we simply ignoring all of this features
  merge_requests_access_level                      = "enabled"
  analytics_access_level                           = "disabled"
  builds_access_level                              = "disabled"
  container_registry_access_level                  = "disabled"
  environments_access_level                        = "disabled"
  feature_flags_access_level                       = "disabled"
  forking_access_level                             = "disabled"
  issues_access_level                              = "disabled"
  model_experiments_access_level                   = "disabled"
  model_registry_access_level                      = "disabled"
  monitor_access_level                             = "disabled"
  pages_access_level                               = "disabled"
  releases_access_level                            = "disabled"
  security_and_compliance_access_level             = "disabled"
  snippets_access_level                            = "disabled"
  wiki_access_level                                = "disabled"
  packages_enabled                                 = false
}
