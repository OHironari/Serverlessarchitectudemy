# ===========
# Define Dynamo DB 
# ===========
resource "aws_dynamodb_table" "users" {
  name         = "users"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}




