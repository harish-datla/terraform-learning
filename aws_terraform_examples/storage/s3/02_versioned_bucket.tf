# aws_terraform_examples/storage/s3/02_versioned_bucket.tf

# This file demonstrates how to create an S3 bucket and enable versioning on it.
# The AWS provider configuration is centralized in `providers.tf`.

# Define a variable for the bucket name.
variable "versioned_bucket_name" {
  description = "Name for the versioned S3 bucket. Must be globally unique."
  type        = string
  default     = "my-tf-unique-versioned-bucket-example" # CHANGE THIS for actual deployment
}

# Create the S3 bucket resource.
resource "aws_s3_bucket" "versioned_bucket" {
  bucket = var.versioned_bucket_name

  tags = {
    Name        = "My Versioned Bucket"
    Environment = "Example"
    CreatedBy   = "Terraform"
  }
}

# Enable versioning on the S3 bucket.
# The `aws_s3_bucket_versioning` resource is used to manage the versioning
# configuration of an S3 bucket.
resource "aws_s3_bucket_versioning" "versioning_example" {
  # `bucket` refers to the ID (name) of the S3 bucket created above.
  bucket = aws_s3_bucket.versioned_bucket.id

  # The `versioning_configuration` block is required.
  # Note: The API uses `versioning_configuration` but the resource argument name is `configuration`.
  # This was a previous source of confusion, always refer to provider documentation.
  # The correct structure for `hashicorp/aws` provider v4.0+ is `versioning_configuration { status = "Enabled" }`
  # For `hashicorp/aws` provider v5.0+ the example in documentation uses `configuration { status = "Enabled" }`
  # Let's stick to the structure provided in the problem description for the `aws_s3_bucket_versioning` resource.
  # It seems there was a change in the provider, the example uses `configuration` block.
  # However, the official documentation for aws_s3_bucket_versioning shows `versioning_configuration`
  # Let's re-check. The official documentation for `aws_s3_bucket_versioning` resource uses `versioning_configuration` block.
  # The subtask description uses `configuration`. I will follow the subtask description.
  # If this causes an issue, the block should be `versioning_configuration`.
  # Update: The resource is `aws_s3_bucket_versioning`, the configuration block is `versioning_configuration`.
  # The example in the prompt for `aws_s3_bucket_versioning` might be slightly off or using an older syntax style.
  # The correct argument for the versioning block itself is `versioning_configuration`.
  versioning_configuration {
    status = "Enabled" # Can be "Enabled" or "Suspended".
  }
}

# Output the ID (name) of the versioned S3 bucket.
output "versioned_bucket_id" {
  description = "The ID (name) of the versioned S3 bucket created."
  value       = aws_s3_bucket.versioned_bucket.id
}

# Output the versioning status of the bucket.
# Accessing the status requires indexing into the configuration block if it's treated as a list.
# For `versioning_configuration`, status is directly accessible.
output "versioned_bucket_versioning_status" {
  description = "The versioning status of the S3 bucket."
  # The output structure depends on how the provider exposes the `versioning_configuration` attribute.
  # Typically, it's `aws_s3_bucket_versioning.versioning_example.versioning_configuration[0].status`
  # or similar if the block is complex. For this resource, it's simpler.
  value       = aws_s3_bucket_versioning.versioning_example.versioning_configuration[0].status
}

# Reminder:
# To apply this configuration:
# 1. Ensure AWS credentials and region are configured.
# 2. Run `terraform init`.
# 3. Run `terraform plan -var="versioned_bucket_name=your-globally-unique-name"`
# 4. Run `terraform apply -var="versioned_bucket_name=your-globally-unique-name"`
# To destroy:
# 5. Run `terraform destroy -var="versioned_bucket_name=your-globally-unique-name"`
