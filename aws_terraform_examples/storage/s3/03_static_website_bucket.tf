# aws_terraform_examples/storage/s3/03_static_website_bucket.tf

# This file demonstrates how to configure an S3 bucket for static website hosting.
# The AWS provider configuration is centralized in `providers.tf`.

# Define a variable for the bucket name.
variable "website_bucket_name" {
  description = "Name for the S3 static website bucket. Must be globally unique."
  type        = string
  default     = "my-tf-unique-static-website-example" # CHANGE THIS for actual deployment
}

# Create the S3 bucket resource.
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.website_bucket_name

  tags = {
    Name        = "My Static Website Bucket"
    Environment = "Example"
    CreatedBy   = "Terraform"
  }
}

# Configure the S3 bucket for static website hosting.
# This resource defines the index and error documents for the website.
resource "aws_s3_bucket_website_configuration" "website_configuration_example" {
  bucket = aws_s3_bucket.website_bucket.id

  # Specifies the home or default page of the website.
  index_document {
    suffix = "index.html"
  }

  # Specifies the error page to return for 4XX class errors.
  error_document {
    key = "error.html"
  }

  # Note: For a publicly accessible static website, you would also need to:
  # 1. Make the objects public (e.g., by setting ACLs on objects or a bucket policy).
  # 2. Configure `aws_s3_bucket_public_access_block` to allow public access.
  # This example focuses solely on the website configuration resource itself.
  # See the main README.md in this directory for more details.
}

# Output the ID (name) of the S3 static website bucket.
output "website_bucket_id" {
  description = "The ID (name) of the S3 static website bucket created."
  value       = aws_s3_bucket.website_bucket.id
}

# Output the website endpoint URL for the S3 bucket.
# This is the URL you would use to access the static website.
output "website_bucket_endpoint" {
  description = "The website endpoint of the S3 static website bucket."
  # The attribute `website_endpoint` is available on the `aws_s3_bucket` resource
  # if a `website` block is configured directly, or on `aws_s3_bucket_website_configuration`.
  value = aws_s3_bucket_website_configuration.website_configuration_example.website_endpoint
}

# Reminder:
# To apply this configuration:
# 1. Ensure AWS credentials and region are configured.
# 2. Run `terraform init`.
# 3. Run `terraform plan -var="website_bucket_name=your-globally-unique-name-for-website"`
# 4. Run `terraform apply -var="website_bucket_name=your-globally-unique-name-for-website"`
# To destroy:
# 5. Run `terraform destroy -var="website_bucket_name=your-globally-unique-name-for-website"`
