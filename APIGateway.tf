# ===========
# Define API Gateway
# ===========

resource "aws_api_gateway_rest_api" "users_api" {
  name        = "users-api"
}

resource "aws_api_gateway_resource" "users" {
  rest_api_id = aws_api_gateway_rest_api.users_api.id
  parent_id   = aws_api_gateway_rest_api.users_api.root_resource_id
  path_part   = "users"
}

resource "aws_api_gateway_method" "post_users" {
  rest_api_id   = aws_api_gateway_rest_api.users_api.id
  resource_id   = aws_api_gateway_resource.users.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_post_users" {
  rest_api_id = aws_api_gateway_rest_api.users_api.id
  resource_id = aws_api_gateway_resource.users.id
  http_method = aws_api_gateway_method.post_users.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.users_post_function.invoke_arn

  request_templates = {
    "application/json" = <<EOF
{
  "body": "$util.escapeJavaScript($input.body)"
}
EOF
  }

  depends_on = [ aws_lambda_function.users_post_function ]
}

resource "aws_api_gateway_deployment" "example" {
  depends_on = [aws_api_gateway_integration.lambda_post_users]

  rest_api_id = aws_api_gateway_rest_api.users_api.id
  stage_name  = "users-stage"
}