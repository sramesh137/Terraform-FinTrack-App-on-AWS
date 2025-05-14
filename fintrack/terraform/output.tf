output "public_dns_with_port" {
    description = "The public DNS of the instance with port"
    value       = "http://${aws_instance.fintrack.public_dns}:5001" # Appends port 5001 to the public DNS
}
