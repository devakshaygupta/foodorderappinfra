output "get_user_function_arn" {
  value = aws_lambda_function.get-users.invoke_arn
}