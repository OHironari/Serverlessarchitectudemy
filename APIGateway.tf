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

resource "aws_api_gateway_deployment" "all" {
  depends_on = [
    aws_api_gateway_integration.lambda_post_users,
    aws_api_gateway_integration.lambda_get_users,
    aws_api_gateway_integration.lambda_put_users,
    aws_api_gateway_integration.lambda_delete_users,
  ]

  rest_api_id = aws_api_gateway_rest_api.users_api.id
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "users-stage"
  rest_api_id   = aws_api_gateway_rest_api.users_api.id
  deployment_id = aws_api_gateway_deployment.all.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw_logs.arn
    format = jsonencode({
      requestId        = "$context.requestId"
      ip               = "$context.identity.sourceIp"
      caller           = "$context.identity.caller"
      user             = "$context.identity.user"
      requestTime      = "$context.requestTime"
      httpMethod       = "$context.httpMethod"
      resourcePath     = "$context.resourcePath"
      status           = "$context.status"
      responseLength   = "$context.responseLength"
    })
  }
}
resource "aws_api_gateway_account" "api_account" {
  cloudwatch_role_arn = aws_iam_role.api_gw_cloudwatch_role.arn
}

# ------
# POST
# ------
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
  type                    = "AWS"
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

# ------
# GET
# ------
resource "aws_api_gateway_method" "get_users" {
  rest_api_id   = aws_api_gateway_rest_api.users_api.id
  resource_id   = aws_api_gateway_resource.users.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_get_users" {
  rest_api_id = aws_api_gateway_rest_api.users_api.id
  resource_id = aws_api_gateway_resource.users.id
  http_method = aws_api_gateway_method.get_users.http_method

  integration_http_method = "GET"
  type                    = "AWS"
  uri                     = aws_lambda_function.users_get_function.invoke_arn

  request_templates = {
    "application/json" = <<EOF
{
    "id" : "$input.params('id')"
}
EOF
}

  depends_on = [ aws_lambda_function.users_get_function ]
}

# ------
# PUT
# ------
resource "aws_api_gateway_method" "put_users" {
  rest_api_id   = aws_api_gateway_rest_api.users_api.id
  resource_id   = aws_api_gateway_resource.users.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_put_users" {
  rest_api_id = aws_api_gateway_rest_api.users_api.id
  resource_id = aws_api_gateway_resource.users.id
  http_method = aws_api_gateway_method.put_users.http_method

  integration_http_method = "PUT"
  type                    = "AWS"
  uri                     = aws_lambda_function.users_put_function.invoke_arn

  request_templates = {
    "application/json" = <<EOF
{
    "body" : "$util.escapeJavaScript($input.body)"
}
EOF
  }

  depends_on = [ aws_lambda_function.users_put_function ]
}


# ------
# DELETE
# ------
resource "aws_api_gateway_method" "delete_users" {
  rest_api_id   = aws_api_gateway_rest_api.users_api.id
  resource_id   = aws_api_gateway_resource.users.id
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_delete_users" {
  rest_api_id = aws_api_gateway_rest_api.users_api.id
  resource_id = aws_api_gateway_resource.users.id
  http_method = aws_api_gateway_method.delete_users.http_method

  integration_http_method = "DELETE"
  type                    = "AWS"
  uri                     = aws_lambda_function.users_delete_function.invoke_arn

  request_templates = {
    "application/json" = <<EOF
{
    "id" : "$input.params('id')"
}
EOF
  }

  depends_on = [ aws_lambda_function.users_delete_function ]
}



