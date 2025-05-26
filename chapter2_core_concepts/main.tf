# chapter2_core_concepts/main.tf

# This file demonstrates the use of Providers, Resources, Variables, and Outputs.

# 1. Terraform Block & Provider Declaration
# We need to tell Terraform which providers we'll be using.
# For this example, we use the "local" provider, which allows us to manage local files.
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0" # Using a version constraint is a good practice
    }
  }
}

# Provider Configuration
# Some providers require configuration (e.g., AWS region, credentials).
# The "local" provider typically doesn't need explicit configuration.
provider "local" {
  # No specific configuration needed for the local provider.
}

# 2. Resource Declaration
# We define a 'local_file' resource named 'core_example'.
# This resource will create a file on the local filesystem.
resource "local_file" "core_example" {
  # The filename is taken from the 'filename' variable defined in variables.tf.
  filename = var.filename

  # The content is constructed using variables defined in variables.tf.
  # We're combining a prefix string with a version number.
  content  = "${var.file_content_prefix}Version ${var.content_version_number}."

  # Other common arguments for local_file (not used here but good to know):
  # directory_permission = "0700" # Permissions for the directory if it needs to be created
  # file_permission      = "0600" # Permissions for the file
}

# How this ties together with other files:
# - variables.tf: Defines var.filename, var.file_content_prefix, and var.content_version_number.
# - outputs.tf: Uses local_file.core_example.filename and local_file.core_example.content
#   to display information about the created file after `terraform apply`.

# To run this example:
# 1. Navigate to the 'chapter2_core_concepts' directory in your terminal.
# 2. Run `terraform init` - This downloads the 'local' provider.
# 3. Run `terraform plan` - This shows you what Terraform will do (create one local file).
# 4. Run `terraform apply` - This executes the plan and creates the file.
#    You will see the outputs defined in outputs.tf displayed in the terminal.
# 5. Inspect the created file (default: core_concepts_example.txt).
# 6. Run `terraform destroy` - This will remove the file created by Terraform.
