# chapter2_core_concepts/variables.tf

# Defines the name for the file that will be created.
variable "filename" {
  description = "The name of the file to be created by Terraform. This will be used by the 'local_file' resource."
  type        = string
  default     = "core_concepts_example.txt"
}

# Defines a prefix for the content of the file.
# This demonstrates using a string variable.
variable "file_content_prefix" {
  description = "A prefix string for the content of the file."
  type        = string
  default     = "Learning Terraform core concepts: "
}

# Defines a number that could represent something like a version or a simple numeric ID.
# This demonstrates using a number variable.
# For this example, we'll imagine it's a version number to append to the content.
variable "content_version_number" {
  description = "A version number to include in the file's content."
  type        = number
  default     = 1
}

# Note: While 'default' values are provided here for ease of use in this example,
# in real-world scenarios, you might omit defaults for required variables to ensure
# they are explicitly set when the module is used.
#
# How to use these variables:
# - In your .tf files: var.filename, var.file_content_prefix, var.content_version_number
# - Override defaults by:
#   1. Creating a terraform.tfvars file.
#   2. Using -var="filename=custom_name.txt" on the command line.
#   3. Setting TF_VAR_filename environment variables.
