data "aws_ecr_repository" "ecr" {
  name = "aws-ecs-reactjs-personal-portfolio"
}

# vpc details :
data "aws_vpc" "this_vpc" {
  state = "available"
  filter {
    name   = "tag:Name"
    values = ["custom-vpc"]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = ["WebSG"]
  }
}

data "aws_security_group" "ext_alb" {
  filter {
    name   = "tag:Name"
    values = ["InternetFacing-ALB"]
  }
}

# subnets details :
data "aws_subnet" "web_subnet_1a" {
  vpc_id = data.aws_vpc.this_vpc.id
  filter {
    name   = "tag:Name"
    values = ["weblayer-pub1-1a"]
  }
}

data "aws_subnet" "web_subnet_1b" {
  vpc_id = data.aws_vpc.this_vpc.id
  filter {
    name   = "tag:Name"
    values = ["weblayer-pub2-1b"]
  }
}

# Fetching the details of target group:
data "aws_lb_target_group" "this_tg" {
  name = "TargetGroup-External"
}

data "aws_lb" "this_lb" {
  name = "ALB-External"
}

data "aws_lb_listener" "this_lb_listener" {
  load_balancer_arn = data.aws_lb.this_lb.arn
  port              = 80
}