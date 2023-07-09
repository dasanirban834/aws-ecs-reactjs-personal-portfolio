resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = var.ecs_details["Name"]
  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.kms.arn
      logging    = var.ecs_details["logging"]
      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.log-group.name
      }
    }
  }
  tags = var.custom_tags
}

resource "aws_ecs_task_definition" "taskdef" {
  family                   = var.ecs_task_def["family"]
  container_definitions    = jsonencode([
    {
      "name": "${var.ecs_task_def["cont_name"]}",
      "image": "${data.aws_ecr_repository.ecr.repository_url}:latest",
      "entrypoint": [],
      "essential": "${var.ecs_task_def["essential"]}",
      "logConfiguration": {
        "logDriver": "${var.ecs_task_def["logdriver"]}",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "app-prd"
        }
      },
      "portMappings": [
        {
          "containerPort": "${var.ecs_task_def["containerport"]}",
        }
      ],
      "cpu": "${var.ecs_task_def["cpu"]}",
      "memory": "${var.ecs_task_def["memory"]}",
      "networkMode": "${var.ecs_task_def["networkmode"]}"
    }
  ])

  requires_compatibilities = var.ecs_task_def["requires_compatibilities"]
  network_mode             = var.ecs_task_def["networkmode"]
  memory                   = var.ecs_task_def["memory"]
  cpu                      = var.ecs_task_def["cpu"]
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  tags = var.custom_tags
}

resource "aws_ecs_service" "aws_ecs-service" {
  name                 = var.ecsservice["name"]
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.taskdef.family
  launch_type          = var.ecsservice["launch_type"]
  scheduling_strategy  = var.ecsservice["scheduling_strategy"]
  desired_count        = var.ecsservice["desired_count"]
  force_new_deployment = var.ecsservice["force_new_deployment"]
  health_check_grace_period_seconds = 100

  network_configuration {
    subnets          = [data.aws_subnet.web_subnet_1a.id, data.aws_subnet.web_subnet_1b.id]
    assign_public_ip = true
    security_groups = [
      data.aws_security_group.sg.id
    ]
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.this_tg.id
    container_name   = "ReactJS-Container"
    container_port   = 3000
  }
  depends_on = [
    data.aws_lb_listener.this_lb_listener,
    ]

}