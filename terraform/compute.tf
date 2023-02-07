resource "yandex_compute_instance" "vm-1" {
  name = "ls-lab-2-instance"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8emvfmfoaordspe1jr"
      size = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.ls-lab-2-subnet.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./cloud-config.yaml")}"
  }

  allow_stopping_for_update = true
}