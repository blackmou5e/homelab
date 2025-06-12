resource "proxmox_virtual_environment_vm" "k8s-master" {
  name = "k8s-master-0"
  description = "Deckhouse master"
  tags = ["k8s", "master", "tofu"]

  node_name = "proxmox"
  pool_id = "k8s"

  agent {
    enabled = true
    timeout = "5m"
  }
  stop_on_destroy = true
  startup {
    order = "3"
    up_delay = "60"
    down_delay = "60"
  }

  machine = "q35"
  bios = "ovmf"

  cpu {
    cores = 4
    type = "host"
    flags = []
  }

  memory {
    dedicated = 8192
  }

  efi_disk {
    type = "4m"
    file_format = "raw"
  }

  disk {
    datastore_id = "ssd"
    file_id = "local:iso/jammy-server-cloudimg-amd64.img"
    interface = "scsi0"
    size = 50
    file_format = "raw"
    path_in_datastore = "vm-101-disk-2"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.31.10/24"
        gateway = "192.168.31.1"
      }
    }

    user_account {
      username = "ubuntu"
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHS6EBhbA6MGiFVmej1t6Peqr/V36bCFivuwadPtxtGM homelab"
      ]
      password = "Develop"
    }

    interface = "ide2"

    vendor_data_file_id = "local:snippets/terraform-provider-proxmox-example-vendor-config.yaml"
  }

  network_device {
    bridge = "vmbr0"
    mtu = 1500
    mac_address = "BC:24:11:2B:61:B9"
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
    type = "serial0"
  }

  serial_device {}
}
