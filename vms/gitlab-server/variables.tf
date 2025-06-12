variable "proxmox_endpoint" {
  description = "The proxmox API endpoint"
  type        = string
  sensitive   = true
}

variable "proxmox_username" {
  description = "The proxmox API username"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token" {
  description = "The proxmox API token"
  type        = string
  sensitive   = true
}

variable "vm_username" {
  type    = string
}

variable "vm_ssh_key" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}
