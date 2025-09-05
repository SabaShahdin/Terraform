# RDS MySQL Database
resource "huaweicloud_rds_instance" "mysql" {
  name              = "my-db"
  flavor            = "rds.mysql.c3.large.2"
  volume {
    type = "ULTRAHIGH"
    size = 100
  }

  region            = "ap-southeast-3"
  availability_zone = ["ap-southeast-3a"]  # ✅ list
  vpc_id            = huaweicloud_vpc.vpc.id
  subnet_id         = huaweicloud_vpc_subnet.subnet.id
  security_group_id = huaweicloud_networking_secgroup.sg.id

  db {
    type           = "MySQL"
    version        = "5.7"
    port           = 3306
    password       = "YourStrongPass123!"
  }
}
  output "rds_endpoint" {
  value = huaweicloud_rds_instance.mysql.private_ips[0]
  description = "Private IP of the RDS instance"
}



