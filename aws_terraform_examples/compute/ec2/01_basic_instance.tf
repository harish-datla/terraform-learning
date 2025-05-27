# aws_terraform_examples/compute/ec2/01_basic_instance.tf

# This file demonstrates how to launch a basic EC2 instance.
# It uses common variables defined in `variables.tf` for AMI ID and instance type.
# The AWS provider configuration is centralized in `providers.tf`.

# Create the EC2 instance resource.
resource "aws_instance" "basic_ec2" {
  # AMI ID for the instance. Sourced from variables.tf.
  # Example: Amazon Linux 2 LTS. Ensure this AMI is available in your selected region.
  ami = var.ec2_ami_id

  # Instance type for the EC2 instance. Sourced from variables.tf.
  # Example: t2.micro, which is often eligible for the AWS Free Tier.
  instance_type = var.ec2_instance_type

  # Tags are key-value pairs that you can assign to AWS resources.
  # Here, we merge the default_tags from variables.tf with instance-specific tags.
  tags = merge(
    var.default_tags,
    {
      Name = "Basic-EC2-Example-01"
    }
  )
}

# Output the ID of the created EC2 instance.
output "basic_ec2_instance_id" {
  description = "The ID of the basic EC2 instance created."
  value       = aws_instance.basic_ec2.id
}

# Output the public IP address of the EC2 instance.
# Note: If an instance is stopped and started, the public IP might change unless an Elastic IP is associated.
output "basic_ec2_public_ip" {
  description = "The public IP address of the basic EC2 instance."
  value       = aws_instance.basic_ec2.public_ip
}

# Output the public DNS of the EC2 instance.
output "basic_ec2_public_dns" {
  description = "The public DNS name of the basic EC2 instance."
  value       = aws_instance.basic_ec2.public_dns
}

# Reminder:
# To apply this configuration:
# 1. Ensure AWS credentials and region are configured (via providers.tf or environment).
# 2. Verify/update `ec2_ami_id` in `variables.tf` for your region.
# 3. Run `terraform init` in this directory (`aws_terraform_examples/compute/ec2/`).
# 4. Run `terraform plan`
# 5. Run `terraform apply`
# To destroy:
# 6. Run `terraform destroy`
