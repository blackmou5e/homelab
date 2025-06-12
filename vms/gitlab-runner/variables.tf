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

variable "gitlab_base_url" {
  description = "Your gitlab-server instance base url"
  type        = string
}

variable "gitlab_token" {
  description = "The gitlab admin token"
  type        = string
  sensitive   = true
}

variable "gitlab_runner_executor" {
  description = "What kind of executor will be deployed"
  type        = string
}

variable "vm_username" {
  description = "Username for root/admin account on created VMs."
  type        = string
  default     = "ubuntu"
}

variable "vm_ssh_key" {
  description = "Public ssh key for root/admin account on created VMs."
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "Password for root/admin account on created VMs."
  type        = string
  default     = "Develop"
  sensitive   = true
}

variable "vm_amount" {
  description = "How many runner VMs we should create."
  type        = number
  default     = 1
}
