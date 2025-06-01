variable "bucket_name" {
  type        = string
  description = "S3 bucket name for storing Terraform state"
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table name for state locking"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
