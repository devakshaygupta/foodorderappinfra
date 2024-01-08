data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../../../Backend/${var.get-users-function-name}.py"
  output_path = "lambda_function_payload.zip"
}

