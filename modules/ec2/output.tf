output "instance_public_ip" {
  value = aws_eip.cluster-eip.public_ip
}