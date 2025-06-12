resource "proxmox_virtual_environment_file" "vendor_config" {
    content_type = "snippets"
    datastore_id = "local"
    node_name = "proxmox"

    source_raw {
      file_name = "terraform-provider-proxmox-example-vendor-config.yaml"
      data = <<EOF
#cloud-config
package_update: true
package_upgrade: true
packages:
  - open-vm-tools
  - qemu-guest-agent
  - python3
runcmd:
  - systemctl daemon-reload
  - systemctl enable --now qemu-guest-agent
  - echo "done" > /tmp/vendor-cloud-init-done
EOF
    }
}
