# aws_terraform_examples/storage/s3/01_private_bucket.tf

# This file demonstrates how to create a simple, private S3 bucket.
# The AWS provider configuration is centralized in `providers.tf`.

# Define a variable for the bucket name.
# S3 bucket names must be globally unique. For real deployments, consider
# adding a random suffix or using a naming convention that ensures uniqueness.
variable "private_bucket_name" {
  description = "Name for the private S3 bucket. Must be globally unique."
  type        = string
  default     = "my-tf-unique-private-bucket-example" # CHANGE THIS for actual deployment
}

# Create the S3 bucket resource.
# By default, S3 buckets are private. The `acl` argument is deprecated
# in favor of `aws_s3_bucket_ownership_controls` and `aws_s3_bucket_acl`
# for fine-grained control, but for a simple private bucket, default settings
# with Block Public Access usually suffice.
resource "aws_s3_bucket" "private_bucket" {
  bucket = var.private_bucket_name

  # Tags are useful for cost tracking, automation, and organization.
  tags = {
    Name        = "My Private Bucket"
    Environment = "Example"
    CreatedBy   = "Terraform"
  }
}

# Output the ID (name) of the private S3 bucket.
output "private_bucket_id" {
  description = "The ID (name) of the private S3 bucket created."
  value       = aws_s3_bucket.private_bucket.id
}

# Output the ARN (Amazon Resource Name) of the private S3 bucket.
output "private_bucket_arn" {
  description = "The ARN of the private S3 bucket created."
  value       = aws_s3_bucket.private_bucket.arn
}

# Reminder:
# To apply this configuration:
# 1. Ensure AWS credentials and region are configured (via providers.tf or environment).
# 2. Run `terraform init` in this directory (`aws_terraform_examples/storage/s3/`).
# 3. Run `terraform plan -var="private_bucket_name=your-globally-unique-name"`
# 4. Run `terraform apply -var="private_bucket_name=your-globally-unique-name"`
# To destroy:
# 5. Run `terraform destroy -var="private_bucket_name=your-globally-unique-name"`
