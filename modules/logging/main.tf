resource "aws_cloudwatch_log_group" "first-function" {
  name              = "/aws/lambda/${var.first-function-name}"
  retention_in_days = 1
}