# aws_terraform_examples/compute/ec2/03_instance_with_eip.tf

# This file demonstrates how to launch an EC2 instance and associate an Elastic IP (EIP) with it.
# This provides the instance with a static public IP address that persists across stops/starts.
# It uses common variables defined in `variables.tf`.
# The AWS provider configuration is centralized in `providers.tf`.

# Create the EC2 instance.
# For this example, we might want to use a different security group or no specific SG if it's just for EIP demo.
# However, for an instance to be reachable (e.g. for SSH), it would need a security group like in 02_instance_with_security_group.tf.
# For simplicity in this EIP-focused example, we'll omit explicit SG association here,
# meaning it would use the default security group of the VPC unless specified.
# In a real scenario, always assign appropriate security groups.
resource "aws_instance" "ec2_for_eip" {
  ami           = var.ec2_ami_id      # Sourced from variables.tf
  instance_type = var.ec2_instance_type # Sourced from variables.tf

  # If you intend to SSH into this instance, you should associate a security group
  # that allows SSH access, similar to the '02_instance_with_security_group.tf' example.
  # For example:
  # vpc_security_group_ids = [aws_security_group.ec2_sg_ssh.id] # Assuming ec2_sg_ssh is defined or referenced.

  tags = merge(
    var.default_tags,
    {
      Name = "EC2-With-EIP-Example-03"
    }
  )
}

# Allocate an Elastic IP (EIP).
resource "aws_eip" "example_eip" {
  # The `instance` argument associates this EIP with the EC2 instance created above.
  # This is the legacy way for EC2-Classic EIPs.
  # For VPC EIPs (most common), you should use `instance = aws_instance.ec2_for_eip.id`
  # or `network_interface = aws_instance.ec2_for_eip.primary_network_interface_id`.
  # The `domain` or `vpc` argument was previously used to distinguish.
  # The current provider versions infer this correctly. `instance` is sufficient for association.
  instance = aws_instance.ec2_for_eip.id

  # Alternatively, for VPC scope (which is default now):
  # vpc = true # This argument is deprecated and no longer necessary.
  # The provider automatically handles EIPs in VPC scope.

  tags = merge(
    var.default_tags,
    {
      Name = "EIP-For-EC2-Example-03"
    }
  )
}

# Output the ID of the EC2 instance.
output "ec2_for_eip_instance_id" {
  description = "The ID of the EC2 instance associated with the EIP."
  value       = aws_instance.ec2_for_eip.id
}

# Output the allocated Elastic IP address.
output "ec2_eip_address" {
  description = "The allocated Elastic IP address."
  value       = aws_eip.example_eip.public_ip
}

# Output the EIP allocation ID.
output "ec2_eip_allocation_id" {
  description = "The allocation ID of the Elastic IP."
  value       = aws_eip.example_eip.id # The EIP's allocation ID
}

# Reminder:
# - EIPs incur costs while allocated, especially if not associated with a running instance.
# - Remember to `terraform destroy` to release the EIP and terminate the instance.
