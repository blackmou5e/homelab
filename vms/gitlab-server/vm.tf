resource "proxmox_virtual_environment_vm" "gitlab_server" {
  name        = "gitlab-server"
  description = "VM for tests"
  tags        = ["gitlab", "server", "tofu"]

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
    cores = 8
    type  = "host"
    flags = []
  }

  memory {
    dedicated = 16384
  }

  efi_disk {
    type        = "4m"
    file_format = "raw"
  }

  disk {
    datastore_id      = "ssd"
    file_id           = "local:iso/jammy-server-cloudimg-amd64.img"
    interface         = "scsi0"
    size              = 200
    file_format       = "raw"
    path_in_datastore = "vm-101-disk-2"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.31.3/24"
        gateway = "192.168.31.1"
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
    mac_address  = "BC:24:11:2B:61:B9"
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

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tmpl", {
    address = proxmox_virtual_environment_vm.gitlab_server.ipv4_addresses[1][0]
  })
  filename = "${path.module}/ansible/inventory.ini"
}
