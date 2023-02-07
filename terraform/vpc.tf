resource "yandex_vpc_network" "ls-lab-2-network" {
  name = "ls-lab-2-network"
}

resource "yandex_vpc_subnet" "ls-lab-2-subnet" {
  name           = "ls-lab-2-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.ls-lab-2-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}