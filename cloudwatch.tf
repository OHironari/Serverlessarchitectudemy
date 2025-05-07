# ===========
# Define Cloud Watch
# ===========

# For API Gateway
resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = "/aws/apigateway/users-api"
  retention_in_days = 14
}

