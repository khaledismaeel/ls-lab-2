terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.85.0"
    }
  }
}

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

resource "yandex_vpc_network" "ls-lab-2-network" {
  name = "ls-lab-2-network"
}

resource "yandex_vpc_subnet" "ls-lab-2-subnet" {
  name           = "ls-lab-2-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.ls-lab-2-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}