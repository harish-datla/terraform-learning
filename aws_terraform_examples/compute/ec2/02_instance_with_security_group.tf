# aws_terraform_examples/compute/ec2/02_instance_with_security_group.tf

# This file demonstrates how to launch an EC2 instance with a dedicated security group
# that allows SSH access.
# It uses common variables defined in `variables.tf`.
# The AWS provider configuration is centralized in `providers.tf`.

# Create a Security Group to allow SSH inbound traffic.
resource "aws_security_group" "ec2_sg_ssh" {
  name        = "ec2_example_ssh_sg" # Name for the security group
  description = "Allow SSH inbound traffic"

  # Ingress rule for SSH
  ingress {
    description      = "SSH access from specified CIDR blocks"
    from_port        = 22 # Standard SSH port
    to_port          = 22
    protocol         = "tcp"
    # CIDR blocks allowed for SSH access. Sourced from variables.tf.
    # WARNING: 0.0.0.0/0 allows access from ANY IP address on the internet.
    # This is NOT recommended for production environments.
    # Restrict this to your specific IP address or network range.
    cidr_blocks      = var.sg_ssh_cidr_blocks
  }

  # Egress rule (outbound traffic)
  # By default, security groups allow all outbound traffic.
  # You can explicitly define egress rules if you need to restrict outbound connections.
  egress {
    from_port        = 0 # Allow all ports
    to_port          = 0
    protocol         = "-1" # Allow all protocols
    cidr_blocks      = ["0.0.0.0/0"] # Allow outbound traffic to any IP
  }

  tags = merge(
    var.default_tags,
    {
      Name = "EC2-SG-SSH-Example-02"
    }
  )
}

# Create the EC2 instance and associate it with the security group.
resource "aws_instance" "ec2_with_sg" {
  ami           = var.ec2_ami_id      # Sourced from variables.tf
  instance_type = var.ec2_instance_type # Sourced from variables.tf

  # Associate the security group created above with this instance.
  # `vpc_security_group_ids` expects a list of security group IDs.
  vpc_security_group_ids = [aws_security_group.ec2_sg_ssh.id]

  # It's good practice to specify a key pair for SSH access, though not strictly required by Terraform.
  # key_name = "your-key-pair-name" # Replace with your EC2 key pair name if you want to SSH into the instance.

  tags = merge(
    var.default_tags,
    {
      Name = "EC2-With-SG-Example-02"
    }
  )
}

# Output the ID of the EC2 instance.
output "ec2_with_sg_instance_id" {
  description = "The ID of the EC2 instance with a security group."
  value       = aws_instance.ec2_with_sg.id
}

# Output the public IP address of the EC2 instance.
output "ec2_with_sg_public_ip" {
  description = "The public IP address of the EC2 instance with a security group."
  value       = aws_instance.ec2_with_sg.public_ip
}

# Output the ID of the security group.
output "ec2_with_sg_security_group_id" {
  description = "The ID of the security group associated with the EC2 instance."
  value       = aws_security_group.ec2_sg_ssh.id
}

# Reminder:
# - For actual SSH access, ensure you have an EC2 key pair specified in `key_name`
#   and the corresponding private key.
# - Restrict `sg_ssh_cidr_blocks` in `variables.tf` for production.
