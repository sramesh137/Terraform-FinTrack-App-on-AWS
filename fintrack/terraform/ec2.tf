# Create an EC2 instance named "fintrack"
resource "aws_instance" "fintrack" {
  ami                    = data.aws_ami.ubuntu_linux.id                   # Use the latest Ubuntu Linux AMI
  instance_type          = "t2.micro"                                  # Instance type is t2.micro (free tier eligible)
  subnet_id              = aws_subnet.fintrack_subnet.id               # Launch in the specified subnet
  vpc_security_group_ids = [aws_security_group.fintrack_sg.id]         # Attach the specified security group
  user_data              = file("${path.module}/scripts/user_data.sh") # Run user data script at launch
  key_name               = aws_key_pair.fintrack_key.key_name          # Use the specified key pair for SSH access
  # add tags to the instance for identification
  tags = {
    Name = "${var.name}-ec2"
  }
}
