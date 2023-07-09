output "arn" {
  value = [aws_lb.this_alb.arn]
}

output "dns_name" {
  value = [aws_lb.this_alb.dns_name]
}