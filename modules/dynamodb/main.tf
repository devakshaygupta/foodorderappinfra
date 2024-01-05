resource "aws_dynamodb_table" "serverless_workshop_intro" {
  name           = var.dynamodb-table-name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "_id"

  attribute {
    name = "_id"
    type = "S"
  }

}