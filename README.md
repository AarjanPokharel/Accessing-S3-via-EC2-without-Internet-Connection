# Accessing-S3-via-EC2-without-Internet-Connection-Using-VPC-Gateway-Endpoint

This project demonstrates how to securely connect EC2 instances in a private subnet to Amazon S3 without using an internet connection, using a VPC Gateway Endpoint. This approach provides enhanced security, improves performance, reduces costs, and simplifies network architecture while ensuring reliable and managed connectivity to S3. In this project, a VPC Gateway Endpoint was configured to enable an EC2 instance in a private subnet to securely access an S3 bucket without public internet access. This setup ensures that traffic remains within the AWS network, keeping sensitive data secure while allowing essential connectivity.


# ARCHITECTURE

1. A VPC with:

- Internet Gateway: For internet connectivity in the public subnet
- Public Subnet: Contains the EC2 instance that will be used as a Bastion Host for the EC2 in the private subnet.
- Private Subnet: Contains the EC2 instance that requires S3 access.
- VPC Gateway Endpoint for S3: Enables private network access to S3.

2. EC2 Instance in the private subnet:
- No public IP or internet access.
- Uses IAM roles with the necessary permissions to access S3.

3. Amazon S3 Bucket:
- Configured with bucket policies that allow access only through the VPC endpoint.

# What has been done
- Initialized Terraform: Set up the Terraform environment to manage and deploy the AWS infrastructure.

- Created a VPC: Defined a Virtual Private Cloud (VPC) with both public and private subnets, configured for secure network segmentation.

- Configured a VPC Gateway Endpoint for S3: Established a VPC Gateway Endpoint to enable the EC2 instance in the private subnet to access S3 /without requiring public internet access.

- Provisioned an EC2 Instance in the Private Subnet: Launched an EC2 instance in the private subnet with no public IP, ensuring it remains isolated from the public internet.

- Applied S3 Bucket Policies for Restricted Access: Configured S3 bucket policies to restrict access specifically to requests coming through the VPC endpoint, ensuring secure and controlled access.

- Attached Necessary IAM Roles: Assigned IAM roles to the EC2 instance with permissions to access S3, enabling secure, role-based access control.

- Deployed Infrastructure via Terraform: Applied the Terraform configuration to automate the deployment of the entire infrastructure

# Usage
- SSH into the EC2 instance via the Bastion host 
- Use the AWS CLI  the EC2 instance to access and interact with your S3 bucket privately