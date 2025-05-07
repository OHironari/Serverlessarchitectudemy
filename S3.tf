# ===========
# Define Lambda Function
# ===========
resource "aws_s3_bucket" "s3_lambda_resource_bucket" {
  bucket = "lambda-resource-bucket-ononari"
}

resource "aws_s3_object" "users_post_function" {
  bucket = aws_s3_bucket.s3_lambda_resource_bucket.id
  key    = "users_post_function.zip"         # S3上のパス
  source = "functions/users_post_function.zip"          # ローカルファイルのパス
  etag   = filemd5("functions/users_post_function.zip") # ファイルの変更検知に必要
}

resource "aws_s3_object" "users_get_function" {
  bucket = aws_s3_bucket.s3_lambda_resource_bucket.id
  key    = "users_get_function.zip"         # S3上のパス
  source = "functions/users_get_function.zip"          # ローカルファイルのパス
  etag   = filemd5("functions/users_get_function.zip") # ファイルの変更検知に必要
}

resource "aws_s3_object" "users_put_function" {
  bucket = aws_s3_bucket.s3_lambda_resource_bucket.id
  key    = "users_put_function.zip"         # S3上のパス
  source = "functions/users_put_function.zip"          # ローカルファイルのパス
  etag   = filemd5("functions/users_put_function.zip") # ファイルの変更検知に必要
}

resource "aws_s3_object" "users_delete_function" {
  bucket = aws_s3_bucket.s3_lambda_resource_bucket.id
  key    = "users_delete_function.zip"         # S3上のパス
  source = "functions/users_delete_function.zip"          # ローカルファイルのパス
  etag   = filemd5("functions/users_delete_function.zip") # ファイルの変更検知に必要
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3_lambda_resource_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_lambda_resource_bucket" {
  bucket                  = aws_s3_bucket.s3_lambda_resource_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on = [
    aws_s3_bucket_policy.s3_lambda_resource_bucket
  ]
}

resource "aws_s3_bucket_policy" "s3_lambda_resource_bucket" {
  bucket = aws_s3_bucket.s3_lambda_resource_bucket.id
  policy = data.aws_iam_policy_document.s3_lambda_resource_bucket.json
}

data "aws_iam_policy_document" "s3_lambda_resource_bucket" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_lambda_resource_bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.lambda_exec_role.arn]
    }
  }
}