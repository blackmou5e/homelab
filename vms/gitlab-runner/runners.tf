resource "proxmox_virtual_environment_vm" "gitlab_runner" {
  count       = var.vm_amount
  name        = "gitlab-runner-${count.index}"
  description = "gitlab-runner VM"
  tags        = ["gitlab", "runner", "tofu"]

  node_name = "proxmox"
  agent {
    enabled = true
    timeout = "5m"
  }
  stop_on_destroy = true
  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  machine = "q35"
  bios    = "ovmf"

  cpu {
    cores = 4
    type  = "host"
    flags = []
  }

  memory {
    dedicated = 8192
  }

  efi_disk {
    type        = "4m"
    file_format = "raw"
  }

  disk {
    file_id           = "local:iso/jammy-server-cloudimg-amd64.img"
    datastore_id      = "ssd"
    path_in_datastore = "gitlab-runner-${count.index}-data"
    interface         = "scsi0"
    file_format       = "raw"
    size              = 100
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = var.vm_username
      keys = [
        var.vm_ssh_key
      ]
      password = var.vm_password
    }

    interface = "ide2"

    vendor_data_file_id = "local:snippets/terraform-provider-proxmox-example-vendor-config.yaml"
  }

  network_device {
    bridge       = "vmbr0"
    mtu          = 1500
    disconnected = false
  }

  operating_system {
    type = "l26"
  }

  tpm_state {
    version = "v2.0"
  }

  vga {
    memory = 16
    type   = "serial0"
  }

  serial_device {}
}


resource "gitlab_user_runner" "runners" {
  count           = var.vm_amount
  description     = "Runner created and managed via terraform/ansible"
  runner_type     = "instance_type"
  untagged        = false
  tag_list        = ["werf", "infra", "test"]
  maximum_timeout = 3600
  locked          = false
  paused          = false
}

locals {
  runners = {
    for i in range(var.vm_amount) : format("%s%02d", "runner", i) => {
      "ip" : proxmox_virtual_environment_vm.gitlab_runner[i].ipv4_addresses[1][0],
      "token" : gitlab_user_runner.runners[i].token
    }
  }
}

resource "local_sensitive_file" "ansible_inventory" {
  content = templatefile(
    "${path.module}/inventory.tmpl",
    {
      runners  = local.runners,
      url      = var.gitlab_base_url,
      executor = var.gitlab_runner_executor
    }
  )
  filename = "${path.module}/ansible/inventory.ini"
}
