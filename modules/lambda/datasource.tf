data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../../../Backend/lambda.py"
  output_path = "lambda_function_payload.zip"
}

