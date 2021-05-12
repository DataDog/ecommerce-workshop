output "instance_id_for_discounts" {
  description = "ID of the EC2 Instance"
  value       = aws_instance.discounts.id
}

output "ssh_to_discounts" {
  description = "SSH to the IP Address of the EC2 Instance"
  value       = "ssh -i ./ecommerceapp ubuntu@${aws_instance.discounts.public_ip}"
}

output "instance_id_for_frontend" {
  description = "ID of the EC2 Instance"
  value       = aws_instance.frontend.id
}

output "ssh_to_frontend" {
  description = "SSH to the IP Address of the EC2 Instance"
  value       = "ssh -i ./ecommerceapp bitnami@${aws_instance.frontend.public_ip}"
}

output "instance_id_for_advertisements" {
  description = "ID of the EC2 Instance"
  value       = aws_instance.advertisements.id
}

output "ssh_to_advertisements" {
  description = "SSH to the IP Address of the EC2 Instance"
  value       = "ssh -i ./ecommerceapp ubuntu@${aws_instance.advertisements.public_ip}"
}

output "instance_id_for_db" {
  description = "ID of the EC2 Instance"
  value       = aws_instance.db.id
}

output "ssh_to_db" {
  description = "SSH to the IP Address of the EC2 Instance"
  value       = "ssh -i ./ecommerceapp ubuntu@${aws_instance.db.public_ip}"
}

output "URL_for_site" {
  value = "http://${aws_instance.frontend.public_ip}:3000"
}
