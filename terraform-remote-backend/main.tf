provider "aws" {
  region = "us-west-2"
}


# 1. S3 bucket
resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-subin-20250522-xyz123"
}

resource "aws_s3_bucket_versioning" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}


# 2. DynamoDB Table 
resource "aws_dynamodb_table" "state_lock_table" {
  name           = "terraform_state_lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# modify ec2
resource "aws_instance" "terraform-state-test" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.micro"
  tags = {
    Name = "test-instance"
  }
}

