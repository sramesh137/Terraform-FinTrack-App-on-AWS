aws_region         = "us-east-1"        # AWS region to deploy resources
vpc_cidr           = "10.0.0.0/16"      # CIDR block for the VPC
subnet_cidr        = "10.0.1.0/24"      # CIDR block for the subnet
availability_zone  = "us-east-1a"       # Availability zone for resources
allowed_ssh_cidr   = ["0.0.0.0/0"]      # Allowed CIDR blocks for SSH access (open to all)
allowed_flask_cidr = ["0.0.0.0/0"]      # Allowed CIDR blocks for Flask access (open to all)
name = "fintrack"  # Name of the resource for tagging
