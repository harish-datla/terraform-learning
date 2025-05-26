# Example for chapter1_introduction/main.tf
# This configuration uses the "local" provider to create a local file
# named "hello_world.txt" with the content "Hello, Terraform World!".

# Define the local_file resource.
# "local_file" is the resource type, provided by the "local" provider.
# "hello_world" is the name we assign to this resource within our Terraform configuration.
resource "local_file" "hello_world" {
  # filename specifies the name of the file to be created on the local filesystem.
  filename = "hello_world.txt"

  # content specifies the content to be written into the file.
  content  = "Hello, Terraform World!"
}

# Output the filename after the resource is created.
# This is useful for confirming the operation or for using this value elsewhere.
output "hello_world_filename" {
  description = "The name of the file created by Terraform."
  value       = local_file.hello_world.filename
}

# To use this configuration:
# 1. Navigate to this directory in your terminal.
# 2. Run `terraform init` to initialize the backend and provider plugins.
# 3. Run `terraform plan` to see what actions Terraform will perform.
# 4. Run `terraform apply` to create the file.
# 5. Run `terraform destroy` to remove the file.
#
# Note: The "local" provider is generally used for learning, testing, or
# managing local artifacts. For cloud infrastructure, you would use providers
# like "aws", "azurerm", "google", etc.
