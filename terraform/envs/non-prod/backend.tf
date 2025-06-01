terraform {
  backend "s3" {
    bucket         = "dev-assign-tfstate"
    key            = "non-prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "dev-assign-locks"
    encrypt        = true
  }
}
