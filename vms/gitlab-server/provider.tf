terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.78.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.4.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = true
  ssh {
    agent    = true
    username = var.proxmox_username
  }
}
