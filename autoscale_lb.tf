# Load Balancer
resource "huaweicloud_elb_loadbalancer" "lb" {
  name              = "my-lb"
  availability_zone = ["ap-southeast-3a"]  # ✅ list

}

# Listener (HTTP)
resource "huaweicloud_elb_listener" "http_listener" {
  name            = "http-listener"
  loadbalancer_id = huaweicloud_elb_loadbalancer.lb.id
  protocol        = "HTTP"
  protocol_port   = 80
}

# Backend Server Group
resource "huaweicloud_elb_pool" "backend_pool" {
  name            = "ecs-backend-pool"
  loadbalancer_id = huaweicloud_elb_loadbalancer.lb.id
  protocol        = "HTTP"
  lb_method       = "ROUND_ROBIN"
  listener_id     = huaweicloud_elb_listener.http_listener.id
}

# Auto Scaling Group
resource "huaweicloud_as_group" "asg" {
  scaling_group_name = "ecs-asg"
  vpc_id = huaweicloud_vpc.vpc.id
  min_instance_number = 1
  max_instance_number = 3
  desire_instance_number = 1
  cool_down_time     = 300
  health_periodic_audit_time = 5
  health_periodic_audit_grace_period = 600
  health_periodic_audit_method = "ELB_AUDIT"
  delete_publicip = false

  networks {
    id = huaweicloud_vpc_subnet.subnet.id
  }
}

resource "huaweicloud_as_configuration" "as_config" {
  scaling_configuration_name = "ecs-template"
  instance_config {
    flavor      = "s6.small.1"
    image       = "1228013a-31dd-4a42-97ac-6e595a80302a"
    key_name    = huaweicloud_compute_keypair.keypair.name   
    disk {
      size = 40
      disk_type = "SATA"
      volume_type = "SATA"
    }
    public_ip {
      eip {
        ip_type = "5_bgp"
        bandwidth {
          size = 5
          share_type = "PER"
          charging_mode = "traffic"
        }
      }
    }
  }
}