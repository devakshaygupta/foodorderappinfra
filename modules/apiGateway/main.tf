module "lambda" {
  source = "../lambda"
}

resource "aws_api_gateway_rest_api" "ServerlessRESTAPI" {
  name = "ServerlessREST"
}

resource "aws_api_gateway_resource" "get-users" {
  path_part   = "users"
  parent_id   = aws_api_gateway_rest_api.ServerlessRESTAPI.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.ServerlessRESTAPI.id
}

resource "aws_api_gateway_method" "get-user-method" {
  rest_api_id   = aws_api_gateway_rest_api.ServerlessRESTAPI.id
  resource_id   = aws_api_gateway_resource.get-users.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.ServerlessRESTAPI.id
  resource_id             = aws_api_gateway_resource.get-users.id
  http_method             = aws_api_gateway_method.get-user-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.get_user_function_arn
}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.get-users-function-name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.ServerlessRESTAPI.id}/*/${aws_api_gateway_method.get-user-method.http_method}${aws_api_gateway_resource.get-users.path}"
}

resource "aws_api_gateway_deployment" "get-users-deployment" {
  rest_api_id = aws_api_gateway_rest_api.ServerlessRESTAPI.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.ServerlessRESTAPI.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "get-users-v1-stage" {
  deployment_id = aws_api_gateway_deployment.get-users-deployment.id
  rest_api_id   = aws_api_gateway_rest_api.ServerlessRESTAPI.id
  stage_name    = "v1"
  description = "Initial rollout of the API!"
}