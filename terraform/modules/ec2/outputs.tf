output "ec2_security_group_id" {
  value = aws_security_group.ec2.id
}

output "public_ip" {
  value = aws_eip.ec2.public_ip
}

output "instance_id" {
  value = aws_instance.ec2.id
}

output "instance_master_id" {
  value = aws_instance.ec2_master.id
}

output "instance_master_ip" {
  value = aws_instance.ec2_master.private_ip
}
