# Terraform by Example
Flask-Based FinTrack App on AWS with Terraform
# Fintrack AWS Infrastructure

This repository contains Terraform code to provision and manage the AWS infrastructure for the **Fintrack** project. The setup is modular, uses variables for flexibility, and applies DRY principles for tagging.

---

## Project Structure

```
terraform/
├── main.tf           # Core AWS resources (VPC, subnet, IGW, route table, etc.)
├── ec2.tf            # EC2 instance definition
├── data.tf           # Data sources (AMI lookups)
├── variables.tf      # All input variables (including tags)
├── terraform.tfvars  # Variable values for your environment
├── scripts/
│   └── user_data.sh  # User data script for EC2 initialization
└── readme.md         # Project documentation
```

---

## Components

- **VPC**: Isolated network for Fintrack resources
- **Subnet**: Public subnet for EC2
- **Internet Gateway**: Enables internet access
- **Route Table**: Routes outbound traffic
- **Security Group**: Controls inbound/outbound traffic (SSH, app ports)
- **EC2 Instance**: Main compute resource (Ubuntu or Amazon Linux)
- **Key Pair**: For secure SSH access
- **User Data**: Bootstraps the EC2 instance
- **Tags**: Managed via a variable for DRY and consistency

---

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0+)
- AWS CLI configured (`aws configure`)
- An AWS account with sufficient permissions

### Setup

1. **Clone the repository**
   ```sh
   git clone https://github.com/yourusername/fintrack-infra.git
   cd fintrack/terraform
   ```

2. **Initialize Terraform**
   ```sh
   terraform init
   ```

3. **Configure variables**
   - Edit `terraform.tfvars` to match your environment (region, CIDRs, key pair, etc.)

4. **Plan and apply**
   ```sh
   terraform plan
   terraform apply
   ```

---

## Variables

Key variables (see `variables.tf` for all):

- `aws_region`: AWS region (e.g., `us-east-1`)
- `vpc_cidr`: VPC CIDR block
- `subnet_cidr`: Subnet CIDR block
- `availability_zone`: AWS AZ (e.g., `us-east-1a`)
- `allowed_ssh_cidr`: List of CIDRs allowed SSH access
- `allowed_flask_cidr`: List of CIDRs allowed Flask/app access
- `name`: Base name for resources
- `common_tags`: Map of tags applied to all resources

---

## Tagging (DRY Principle)

All resources use the `common_tags` variable from `variables.tf` for consistent tagging. Example:

```hcl
tags = merge(
  var.common_tags,
  {
    Name = "${var.name}-ec2"
  }
)
```

---

## User Data Script

The `scripts/user_data.sh` file is used to bootstrap the EC2 instance (e.g., install packages, create a README, etc.). You can customize this script as needed for your application.

---

## Clean Up

To destroy all resources:

```sh
terraform destroy
```

---
## Screenshots
<img width="1326" alt="fintrack screenshot" src="https://github.com/user-attachments/assets/dcc8a3eb-5978-4093-b87c-3e273a56ee04" />
