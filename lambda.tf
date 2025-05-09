# ===========
# Define Lambda Function
# ===========
# source file in S3 bucket
# ※The lecture not uses S3 bucket

resource "aws_lambda_function" "users_post_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket = aws_s3_bucket.s3_lambda_resource_bucket.bucket
  s3_key = aws_s3_object.users_post_function.key
  function_name = "users-post-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "users_post_function.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }

  depends_on = [ aws_cloudwatch_log_group.post_function_logs ]
}

resource "aws_lambda_function" "users_get_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket = aws_s3_bucket.s3_lambda_resource_bucket.bucket
  s3_key = aws_s3_object.users_get_function.key
  function_name = "users-get-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "users_get_function.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }

  depends_on = [ aws_cloudwatch_log_group.get_function_logs ]
}

resource "aws_lambda_function" "users_put_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket = aws_s3_bucket.s3_lambda_resource_bucket.bucket
  s3_key = aws_s3_object.users_put_function.key
  function_name = "users-put-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "users_put_function.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }

  depends_on = [ aws_cloudwatch_log_group.put_function_logs ]
}

resource "aws_lambda_function" "users_delete_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket = aws_s3_bucket.s3_lambda_resource_bucket.bucket
  s3_key = aws_s3_object.users_delete_function.key
  function_name = "users-delete-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "users_delete_function.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }

  depends_on = [ aws_cloudwatch_log_group.delete_function_logs ]
}

resource "aws_lambda_permission" "allow_apigw_post" {
  statement_id  = "AllowExecutionFromAPIGatewayPost"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users_post_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.users_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_apigw_get" {
  statement_id  = "AllowExecutionFromAPIGatewayGet"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users_get_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.users_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_apigw_put" {
  statement_id  = "AllowExecutionFromAPIGatewayPut"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users_put_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.users_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_apigw_delete" {
  statement_id  = "AllowExecutionFromAPIGatewayDelete"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users_delete_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.users_api.execution_arn}/*/*"
}