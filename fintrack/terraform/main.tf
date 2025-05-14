# Configure the AWS provider with the specified region
provider "aws" {
    region = var.aws_region
}

# Create a VPC to logically isolate resources in the AWS cloud and define a virtual network
resource "aws_vpc" "fintrack_vpc" {
    cidr_block           = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.name}-vpc" # Tag the VPC for identification
    }
}

# Create a public subnet to launch resources (like EC2) that need direct access to the internet
resource "aws_subnet" "fintrack_subnet" {
    vpc_id                  = aws_vpc.fintrack_vpc.id
    cidr_block              = var.subnet_cidr
    availability_zone       = var.availability_zone
    map_public_ip_on_launch = true # Assign public IPs so instances are reachable from the internet
    tags = {
        Name = "${var.name}-subnet" # Tag the subnet for identification
    }
}

# Create an Internet Gateway to allow communication between the VPC and the internet
resource "aws_internet_gateway" "fintrack_igw" {
    vpc_id = aws_vpc.fintrack_vpc.id
    tags = {
        Name = "${var.name}-igw" # Tag the IGW for identification
    }
}

# Create a route table to define how traffic is directed within the VPC
resource "aws_route_table" "fintrack_route_table" {
    vpc_id = aws_vpc.fintrack_vpc.id

    route {
        cidr_block = "0.0.0.0/0" # Route all outbound traffic to the internet via the IGW
        gateway_id = aws_internet_gateway.fintrack_igw.id
    }
    tags = {
        Name = "${var.name}-route-table" # Tag the route table for identification
    }
}

# Associate the route table with the subnet so resources in the subnet use this routing
resource "aws_route_table_association" "fintrack_route_table_association" {
    subnet_id      = aws_subnet.fintrack_subnet.id
    route_table_id = aws_route_table.fintrack_route_table.id
}

# Create a security group to control inbound and outbound traffic for resources in the VPC
resource "aws_security_group" "fintrack_sg" {
    vpc_id = aws_vpc.fintrack_vpc.id

    # Allow SSH access from allowed CIDR blocks for remote management
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.allowed_ssh_cidr
    }

    # Allow access to port 5001 for the fintrack app from allowed CIDR blocks
    ingress {
        from_port   = 5001
        to_port     = 5001
        protocol    = "tcp"
        cidr_blocks = var.allowed_flask_cidr
    }

    # Allow all outbound traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.name}-sg" # Tag the security group for identification
    }
}
