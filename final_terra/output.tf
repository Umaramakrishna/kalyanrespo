
output "prod_server_public_ip" {

value = aws_instance.prod_instance.public_ip
  
}