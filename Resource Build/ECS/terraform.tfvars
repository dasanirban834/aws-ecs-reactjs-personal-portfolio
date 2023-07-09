ecs_details = {
  Name                           = "ecs-cluster"
  logging                        = "OVERRIDE"
  cloud_watch_encryption_enabled = true
}

ecs_task_def = {
  family                   = "custom-task-definition"
  cont_name                = "ReactJS-Container"
  cpu                      = 256
  memory                   = 512
  essential                = true
  logdriver                = "awslogs"
  containerport            = 3000
  networkmode              = "awsvpc"
  requires_compatibilities = ["FARGATE",]
}

ecsservice = {
  name                 = "ecs-service"
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 2
  force_new_deployment = true
}


cw_log_grp = "cloudwatch-log-group-ecs-cluster"

kms_key = {
  description             = "log group encryption"
  deletion_window_in_days = 7
}
