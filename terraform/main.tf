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
    ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOch1nhLIPC0VVrwjgeN2gPEdLrImi+TD5hqDi+RZAHh khaledismaeel@yandex.ru"
  }
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

/*

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

*/