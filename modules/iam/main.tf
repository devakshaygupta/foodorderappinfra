resource "aws_iam_role" "role_for_lambda_function" {
  name               = "role_for_lambda_function"
  assume_role_policy = data.aws_iam_policy_document.policy_for_lambda_role.json
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.role_for_lambda_function.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_policy" "dynamo_db_table_access_policy" {
  name        = "dynamo_db_table_access_policy"
  path        = "/"
  description = "IAM policy for reading or writing to dynamodb from a lambda"
  policy      = data.aws_iam_policy_document.dynamo_db_table_access.json
}

resource "aws_iam_role_policy_attachment" "dynamodb_access" {
  role       = aws_iam_role.role_for_lambda_function.name
  policy_arn = aws_iam_policy.dynamo_db_table_access_policy.arn
}
