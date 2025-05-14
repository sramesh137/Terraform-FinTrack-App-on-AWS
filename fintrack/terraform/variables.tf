# Used to specify the AWS region where all resources will be created
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

# Defines the IP address range for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Specifies the IP address range for the subnet within the VPC
variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

# Determines the specific AWS availability zone for the subnet
variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

# Lists the IP ranges that are permitted SSH access to EC2 instances
variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to access via SSH"
  type        = list(string)
}

# Lists the IP ranges that are allowed to access the Flask application
variable "allowed_flask_cidr" {
  type        = list(string)
  description = "CIDR blocks allowed to access the Flask app"
}

# create tag variables for naming resources
variable "name" {
  description = "Name of the resource"
  type        = string
}
