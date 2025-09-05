# VPC
resource "huaweicloud_vpc" "vpc" {
  name = "my-vpc-1"
  cidr = "192.168.0.0/16"
}

# Subnet
resource "huaweicloud_vpc_subnet" "subnet" {
  name              = "my-subnet"
  cidr              = "192.168.10.0/24"
  gateway_ip        = "192.168.10.1"
  vpc_id            = huaweicloud_vpc.vpc.id
  availability_zone = "ap-southeast-3a"
  dns_list          = ["8.8.8.8", "8.8.4.4"]
}

# Security Group
resource "huaweicloud_networking_secgroup" "sg" {
  name        = "allow-ssh-icmp"
  description = "Allow SSH and ICMP"
}

resource "huaweicloud_networking_secgroup_rule" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.sg.id
}

resource "huaweicloud_networking_secgroup_rule" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.sg.id
}