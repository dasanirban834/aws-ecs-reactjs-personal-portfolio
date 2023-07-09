variable "ecr_repo" {
  description = "Name of repository"
  default     = "aws-ecs-reactjs-personal-portfolio"
}

variable "ecr_tags" {
  type = map(any)
  default = {
    "AppName" = "ReactJS"
    "Env"     = "Dev"
  }
}