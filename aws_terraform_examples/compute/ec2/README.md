# Chapter: AWS EC2 (Elastic Compute Cloud) Examples with Terraform

This section provides practical Terraform examples for provisioning and managing Amazon EC2 instances.

## What is Amazon EC2?

Amazon Elastic Compute Cloud (Amazon EC2) is a web service that provides secure, resizable compute capacity in the cloud. It is designed to make web-scale cloud computing easier for developers. EC2's simple web service interface allows you to obtain and configure capacity with minimal friction.

**Key Concepts:**
*   **Instances:** Virtual servers in the AWS cloud.
*   **Amazon Machine Images (AMIs):** Pre-configured templates for your instances, which package the OS, application server, and applications.
*   **Instance Types:** Various combinations of CPU, memory, storage, and networking capacity for your instances.
*   **Security Groups:** Virtual firewalls that control inbound and outbound traffic to your instances.
*   **Elastic IP Addresses (EIPs):** Static IPv4 addresses designed for dynamic cloud computing.

## Common EC2 Use Cases with Terraform

Terraform is widely used to automate the deployment and management of EC2 instances for various applications:
*   **Web Servers:** Launching and scaling web servers (e.g., Apache, Nginx).
*   **Application Servers:** Deploying backend applications, APIs, and microservices.
*   **Bastion Hosts (Jump Boxes):** Creating secure entry points to your private network.
*   **Development and Test Environments:** Quickly spinning up and tearing down environments for development and testing.
*   **Batch Processing:** Running workloads for batch processing or data analysis.

## Key Terraform AWS Provider Resources Used

The examples in this directory primarily use the following AWS provider resources for EC2:

*   **`aws_instance`**:
    *   The primary resource for creating and managing an EC2 instance.
    *   You specify the AMI, instance type, key pair (for SSH access), security groups, and other configurations.
    *   Documentation: [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

*   **`aws_security_group`**:
    *   Manages a security group, which acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic.
    *   You define rules for `ingress` (inbound) and `egress` (outbound) traffic.
    *   Documentation: [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

*   **`aws_eip`**:
    *   Allocates and manages an Elastic IP address.
    *   EIPs can be associated with EC2 instances to provide a static public IP address.
    *   Documentation: [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)

*   **Data Source: `aws_ami`**: (Not explicitly used in these basic examples but very useful)
    *   Provides a way to fetch information about an AMI, often used to find the latest version of a specific AMI dynamically.
    *   Documentation: [aws_ami data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)

## Overview of Examples in This Directory

*   **`providers.tf`**:
    *   Contains the AWS provider configuration (region, version) for consistency across EC2 examples.

*   **`variables.tf`**:
    *   Defines common variables used in the EC2 examples, such as `ec2_ami_id`, `ec2_instance_type`, `sg_ssh_cidr_blocks`, and `default_tags`. This promotes reusability and makes it easier to customize the examples.

*   **`01_basic_instance.tf`**:
    *   Demonstrates launching a very basic EC2 instance using the `aws_instance` resource.
    *   Uses variables defined in `variables.tf` for AMI ID and instance type.
    *   Outputs the instance ID and public IP address.

*   **`02_instance_with_security_group.tf`**:
    *   Shows how to create an EC2 instance and associate it with a new security group (`aws_security_group`).
    *   The security group is configured to allow SSH access (port 22) from specified CIDR blocks (defaults to `0.0.0.0/0` for example purposes, with a warning for production).
    *   Outputs instance ID, public IP, and security group ID.

*   **`03_instance_with_eip.tf`**:
    *   Illustrates launching an EC2 instance and attaching an Elastic IP (`aws_eip`) to it.
    *   This provides the instance with a static public IP address.
    *   Outputs the instance ID and the allocated EIP.

To use these examples, navigate to this directory (`aws_terraform_examples/compute/ec2/`) in your terminal.
1.  Review and potentially update the `default` value for `ec2_ami_id` in `variables.tf` to ensure it's a valid AMI for your chosen region (default is `us-east-1`).
2.  Run `terraform init` to download the AWS provider.
3.  Run `terraform plan` to review the actions Terraform will take.
4.  Run `terraform apply` to create the resources.
5.  Run `terraform destroy` to remove the resources.

Remember to be mindful of costs associated with running EC2 instances and EIPs. Use `terraform destroy` when you are finished with the examples.
