TG_conf = {
  enabled           = true
  healthy_threshold = "2"
  interval          = "30"
  name              = "TargetGroup-External"
  port              = "3000"
  protocol          = "HTTP"
  target_type       = "ip"
  path              = "/home"
}

ALB_conf = {
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  name               = "ALB-External"
}

Listener_conf = {
  "1" = {
    port     = "80"
    priority = 100
    protocol = "HTTP"
    type     = "forward"
  }
}
