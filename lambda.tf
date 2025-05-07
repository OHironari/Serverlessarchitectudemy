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

