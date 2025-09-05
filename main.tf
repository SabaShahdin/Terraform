# 🔐 Key Pair
resource "huaweicloud_compute_keypair" "keypair" {
  name = "my-keypair"
}

# 🌐 Elastic IP
resource "huaweicloud_vpc_eip" "eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "ecs-bandwidth"
    size        = 5
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

# 💻 ECS Instance
resource "huaweicloud_compute_instance" "ecs" {
  name              = "my-ecs"
  flavor_id         = "s6.small.1"
  image_id          = "1228013a-31dd-4a42-97ac-6e595a80302a"
  availability_zone = "ap-southeast-3a"
  key_pair          = huaweicloud_compute_keypair.keypair.name

  network {
    uuid = huaweicloud_vpc_subnet.subnet.id
  }

  security_groups = [huaweicloud_networking_secgroup.sg.name]
  eip_id          = huaweicloud_vpc_eip.eip.id
}

# Output
output "ecs_public_ip" {
  value       = huaweicloud_vpc_eip.eip.publicip[0].ip_address
  description = "Public IP of the ECS instance"
}
