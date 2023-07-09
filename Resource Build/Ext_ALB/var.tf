variable "TG_conf" {
  type = object({
    name              = string
    port              = string
    protocol          = string
    target_type       = string
    enabled           = bool
    healthy_threshold = string
    interval          = string
    path              = string
  })
}

variable "ALB_conf" {
  type = object({
    name               = string
    internal           = bool
    load_balancer_type = string
    ip_address_type    = string
  })
}

variable "Listener_conf" {
  type = map(object({
    port     = string
    protocol = string
    type     = string
    priority = number
  }))
}

variable "alb_tags" {
  description = "provides the tags for ALB"
  type = object({
    Environment = string
    Email       = string
    Type        = string
    Owner       = string
  })
  default = {
    Email       = "dasanirban0806@gmail.com"
    Environment = "Production"
    Owner       = "Anirban Das"
    Type        = "External"
  }
}
