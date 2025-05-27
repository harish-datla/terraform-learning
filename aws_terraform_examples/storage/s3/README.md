# Chapter: AWS S3 (Simple Storage Service) Examples with Terraform

This section provides practical Terraform examples for provisioning and managing Amazon S3 buckets.

## What is Amazon S3?

Amazon Simple Storage Service (Amazon S3) is an object storage service offering industry-leading scalability, data availability, security, and performance. Customers of all sizes and industries can store and protect any amount of data for virtually any use case, such as data lakes, cloud-native applications, and mobile apps.

**Key Features of S3:**
*   **Durability:** S3 provides 99.999999999% (11 nines) of durability for objects stored.
*   **Scalability:** You can store virtually unlimited amounts of data, and S3 automatically scales to handle high request rates.
*   **Availability:** S3 is designed for 99.99% availability of objects over a given year.
*   **Security:** Offers a variety of access control mechanisms and encryption features.
*   **Cost-Effective:** Pay only for what you use with various storage classes to optimize costs.
*   **Versatility:** Supports a wide range of use cases, from static website hosting to big data analytics.

## Common S3 Use Cases with Terraform

Terraform is frequently used to automate the creation and configuration of S3 buckets for various purposes:
*   **Application Storage:** Creating buckets to store application assets, user uploads, or backups.
*   **Log Storage:** Centralizing logs from various AWS services (e.g., ELB, CloudTrail, VPC Flow Logs) or applications.
*   **Static Website Hosting:** Configuring buckets to host static websites, including HTML, CSS, JavaScript, and image files.
*   **Data Lakes:** Setting up S3 buckets as the foundation for data lakes, where raw data is stored for processing and analysis.
*   **Backup and Archival:** Storing backups and archiving data for long-term retention.

## Key Terraform AWS Provider Resources Used

The examples in this directory primarily use the following AWS provider resources for S3:

*   **`aws_s3_bucket`**:
    *   This is the main resource for creating and managing an S3 bucket.
    *   You can define the bucket name, tags, and other basic properties.
    *   By default, buckets created are private.
    *   Documentation: [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

*   **`aws_s3_bucket_versioning`**:
    *   This resource is used to manage the versioning state of an S3 bucket.
    *   Versioning helps in keeping multiple variants of an object in the same bucket, which can protect against accidental overwrites or deletions.
    *   Documentation: [aws_s3_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)

*   **`aws_s3_bucket_website_configuration`**:
    *   This resource configures an S3 bucket to function as a static website host.
    *   You can specify the index document (e.g., `index.html`) and an error document (e.g., `error.html`).
    *   Documentation: [aws_s3_bucket_website_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration)

*   **`aws_s3_bucket_public_access_block`**: (Mentioned for completeness, not heavily used in these basic examples to maintain focus)
    *   Manages public access settings for an S3 bucket. Crucial for ensuring buckets are not unintentionally exposed.
    *   Documentation: [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)

## Overview of Examples in This Directory

The `.tf` files in this directory demonstrate different S3 configurations:

*   **`providers.tf`**:
    *   Contains the AWS provider configuration, including the required provider version and the AWS region. This ensures consistency across all S3 examples in this directory.

*   **`01_private_bucket.tf`**:
    *   Demonstrates how to create a simple, private S3 bucket with a configurable name.
    *   Includes an output for the bucket ID.

*   **`02_versioned_bucket.tf`**:
    *   Shows how to create an S3 bucket and enable versioning on it using the `aws_s3_bucket_versioning` resource.
    *   Includes outputs for the bucket ID and its versioning status.

*   **`03_static_website_bucket.tf`**:
    *   Illustrates how to configure an S3 bucket for static website hosting, specifying index and error documents using `aws_s3_bucket_website_configuration`.
    *   Includes outputs for the bucket ID and the website endpoint.
    *   **Note:** This example focuses on the website configuration resource. For a publicly accessible static website, you would also need to configure bucket policies (e.g., using `aws_s3_bucket_policy`) and potentially `aws_s3_bucket_public_access_block` to allow public read access to objects. These are not covered in this specific example to keep it focused.

To use these examples, navigate to this directory (`aws_terraform_examples/storage/s3/`) in your terminal and run `terraform init`, then `terraform plan`, and finally `terraform apply` for each `.tf` file or for all at once. Remember that S3 bucket names must be globally unique, so you may need to adjust the default names in the variable blocks.
