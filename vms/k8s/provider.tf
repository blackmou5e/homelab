terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.78.0"
    }
  }
}

variable "proxmox_endpoint" {
  description = "The proxmox API endpoint"
  type = string
  sensitive = true
}

variable "username" {
  description = "The proxmox API username"
  type = string
  sensitive = true
}

variable "api_token" {
  description = "The proxmox API token"
  type = string
  sensitive = true
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  api_token = var.api_token
  insecure = true
  ssh {
    agent = true
    username = var.username
  }
}
