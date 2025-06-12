terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "18.0.0"
    }
  }
}

variable "gitlab_token" {
  description = "The gitlab admin token"
  type        = string
  sensitive   = true
}

provider "gitlab" {
  base_url = "http://192.168.31.3/"
  token    = var.gitlab_token
}
