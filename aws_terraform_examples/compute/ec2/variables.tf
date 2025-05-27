# aws_terraform_examples/compute/ec2/variables.tf

# This file defines common variables used across the EC2 examples in this directory.

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
  # Note: While this variable is defined, the providers.tf currently hardcodes the region.
  # To use this variable, you would modify providers.tf to reference var.aws_region.
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instance. This example uses an Amazon Linux 2 LTS AMI for us-east-1."
  type        = string
  # Common Amazon Linux 2 LTS AMI ID for us-east-1 (check for the latest for your region)
  # You can find AMIs in the AWS Management Console or using the AWS CLI:
  # aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" --query "sort_by(Images, &CreationDate)[-1].[ImageId]" --output text --region us-east-1
  default     = "ami-0c7217cdde317cfec" # Example: Amazon Linux 2 Kernel 5.10 LTS for us-east-1 (as of late 2023/early 2024)
                                        # Please verify and update if necessary for your region or if a newer LTS is available.
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance."
  type        = string
  default     = "t2.micro" # t2.micro is generally available in the AWS Free Tier.
}

variable "sg_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed for SSH access to the EC2 instance. Use with caution."
  type        = list(string)
  default     = ["0.0.0.0/0"] # Allows SSH from anywhere. NOT RECOMMENDED FOR PRODUCTION.
                              # Restrict this to your IP address or a specific range in production.
}

variable "default_tags" {
  description = "Default tags to apply to all resources."
  type        = map(string)
  default = {
    Environment = "Terraform-Example"
    Project     = "EC2-Learning"
    CreatedBy   = "Terraform"
  }
}
