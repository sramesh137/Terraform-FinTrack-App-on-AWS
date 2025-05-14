# Generate a new RSA private key
resource "tls_private_key" "fintrack_key" {
    algorithm = "RSA"      # Use RSA algorithm
    rsa_bits  = 4096       # Key size: 4096 bits
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "fintrack_key" {
    key_name   = "fintrack_key"  # Name for the key pair in AWS EC2
    public_key = tls_private_key.fintrack_key.public_key_openssh  # Use generated public key
}

# Save the generated private key to a local file with restricted permissions
resource "local_file" "fintrack_private_key" {
    content         = tls_private_key.fintrack_key.private_key_pem  # Private key content
    filename        = "${path.module}/fintrack-key.pem"             # File path for private key
    file_permission = "0600"  # Only the owner can read/write
}
