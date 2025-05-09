# ===========
# Define Cloud Watch
# ===========

# For API Gateway
resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = "/aws/apigateway/users-api"
  retention_in_days = 14
}

# For Lambda Function
resource "aws_cloudwatch_log_group" "post_function_logs" {
  name              = "/aws/lambda/users-post-function"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "get_function_logs" {
  name              = "/aws/lambda/users-get-function"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "put_function_logs" {
  name              = "/aws/lambda/users-put-function"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "delete_function_logs" {
  name              = "/aws/lambda/users-delete-function"
  retention_in_days = 14
}


