#terraform {
#  backend "s3" {
#    # Replace this with your bucket name!
#    bucket         = "dev-grupogloria-state"
#    key            = "terraform/state/terraform.tfstate"
#    region         = "us-east-1"
#    # Replace this with your DynamoDB table name!
#    #dynamodb_table = "dev-terraform-up-and-running-locks"
#    encrypt        = true
#  }
#}