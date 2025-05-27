# aws_terraform_examples/storage/s3/providers.tf

# This file defines the AWS provider configuration for all S3 examples
# in this directory.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # It's good practice to pin to a specific major version or use a tight range.
      # For example, "~> 5.0" means any version from 5.0.0 up to, but not including, 6.0.0.
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  # You can specify the region directly, or use a variable.
  # For these examples, we'll hardcode "us-east-1", but in a real-world scenario,
  # you might use a variable like `var.aws_region`.
  region = "us-east-1"

  # Note: AWS credentials are typically configured outside of the Terraform code
  # via environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY),
  # shared credentials files (~/.aws/credentials), or IAM roles for EC2 instances/ECS tasks.
  # Avoid hardcoding credentials in your Terraform files.
}

# Example of how you might use a variable for region (optional, not used by default in these examples):
# variable "aws_region" {
#   description = "The AWS region to deploy resources in."
#   type        = string
#   default     = "us-east-1"
# }
#
# provider "aws" {
#   region = var.aws_region
# }
