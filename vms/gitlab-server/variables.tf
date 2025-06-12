variable "vm_username" {
  type    = string
  default = "ubuntu"
}

variable "vm_ssh_key" {
  type      = string
  default   = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHS6EBhbA6MGiFVmej1t6Peqr/V36bCFivuwadPtxtGM homelab"
  sensitive = true
}

variable "vm_password" {
  type      = string
  default   = "Develop"
  sensitive = true
}
