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
  handler       = "users_post_function.handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function" "users_get_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket = aws_s3_bucket.s3_lambda_resource_bucket.bucket
  s3_key = aws_s3_object.users_get_function.key
  function_name = "users-get-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "users_get_function.handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function" "users_put_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket = aws_s3_bucket.s3_lambda_resource_bucket.bucket
  s3_key = aws_s3_object.users_put_function.key
  function_name = "users-put-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "users_put_function.handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function" "users_delete_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket = aws_s3_bucket.s3_lambda_resource_bucket.bucket
  s3_key = aws_s3_object.users_delete_function.key
  function_name = "users-delete-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "users_delete_function.handler"
  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }
}