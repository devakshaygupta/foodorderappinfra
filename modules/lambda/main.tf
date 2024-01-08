module "iam" {
  source = "../iam"
}

resource "aws_lambda_function" "get-users" {
  filename      = "lambda_function_payload.zip"
  function_name = var.get-users-function-name
  role          = module.iam.lambda_execution_role_arn
  handler       = "${var.get-users-function-name}.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
}