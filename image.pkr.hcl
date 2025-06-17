source "tart-cli" "tart" {

  from_ipsw    = "${lookup(local.sources, var.image.version, "")}"
  vm_name      = "${var.image.name}:${var.image.version}"
  cpu_count    = "${var.image.cpu}"
  memory_gb    = "${var.image.ram}"
  disk_size_gb = "${var.image.disk}"
  ssh_password = "${var.account.username}"
  ssh_username = "${var.account.password}"
  ssh_timeout  = "180s"

  boot_command = "${lookup(local.boot, var.image.version, [])}"

  create_grace_time = "30s"
  recovery_partition = "keep"
}

build {

  sources = ["source.tart-cli.tart"]

  provisioner "file" {
    source      = "scripts/kc-passwd.py"
    destination = "~/kc-passwd.py"
  }

  dynamic "provisioner" {
    for_each = var.install.xcode
    labels = ["file"]
    content {
      source      = "runtime/Xcode-${provisioner.value.version}.xip"
      destination = "~/Xcode-${provisioner.value.version}.xip"
    }
  }

  provisioner "shell" {
    inline = [
      templatefile(
        "${path.root}/scripts/provision.sh",
        {
          account = var.account,
          install = var.install,
          os = var.image.version
        }
      )
    ]
  }
}
