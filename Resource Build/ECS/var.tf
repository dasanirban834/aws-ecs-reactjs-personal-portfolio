variable "region" {
  type    = string
  default = "us-east-1"
}
variable "ecs_role" {
  description = "ecs roles"
  default     = "ecsTaskExecutionRole"
}

variable "ecs_details" {
  description = "details of ECS cluster"
  type = object({
    Name                           = string
    logging                        = string
    cloud_watch_encryption_enabled = bool
  })
}

variable "ecs_task_def" {
  description = "defines the configurations of task definition"
  type = object({
    family                   = string
    cont_name                = string
    cpu                      = number
    memory                   = number
    essential                = bool
    logdriver                = string
    containerport            = number
    networkmode              = string
    requires_compatibilities = list(string)

  })
}

variable "ecsservice" {
  description = "defines the configuration of ecs service"
  type = object({
    name                 = string
    launch_type          = string
    scheduling_strategy  = string
    desired_count        = number
    force_new_deployment = bool
  })
}


variable "cw_log_grp" {
  description = "defines the log group in cloudwatch"
  type        = string
  default     = ""
}

variable "kms_key" {
  description = "defines the kms key"
  type = object({
    description             = string
    deletion_window_in_days = number
  })
}

variable "custom_tags" {
  description = "defines common tags"
  type        = object({})
  default = {
    AppName = "ReactJS"
    Env     = "Dev"
  }
}
