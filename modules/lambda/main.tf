module "iam" {
  source = "../iam"
}

resource "aws_lambda_function" "first-function" {
  filename      = "lambda_function_payload.zip"
  function_name = var.first-function-name
  role          = module.iam.lambda_execution_role_arn
  handler       = "lambda.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
}