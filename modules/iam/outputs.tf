output "lambda_execution_role_arn" {
  value = aws_iam_role.role_for_first_lambda.arn
}