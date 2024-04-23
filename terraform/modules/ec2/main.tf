#--------------------------------------------------------------
# EC2
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "amazon2_amd64" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["amazon"]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon2_amd64.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = "terraform_keypair"
  tags = {
    Name = "${var.app_name}-ec2" 
  }
}

resource "aws_instance" "ec2_master" {
  ami                         = data.aws_ami.amazon2_amd64.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = "terraform_keypair"
  tags = {
    Name = "${var.app_name}-ec2-master" 
  }
}

#--------------------------------------------------------------
# Security group
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "ec2" {
  name = "${var.app_name}-ec2-sg"

  description = "EC2 service security group for ${var.app_name}"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.app_name}-ec2-sg"
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2.id 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2.id
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

# -------------------------------------------------------------
# Elastic IP
# -------------------------------------------------------------
resource "aws_eip" "ec2" {
  instance = aws_instance.ec2.id
  vpc      = true
}

# -------------------------------------------------------------
# provisioner
# -------------------------------------------------------------

resource "null_resource" "ansible_installation" {
  depends_on = [aws_instance.ec2_master]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("terraform_keypair.pem") 
      host        = aws_instance.ec2_master.public_ip
    }

    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install -y epel",
      "sudo yum install -y ansible",
      "echo '[lecture13-ec2]' > ~/ansible_inventory.ini",
      "echo '${aws_eip.ec2.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=terraform_keypair.pem' >> ~/ansible_inventory.ini",
      "echo '${file("terraform_keypair.pem")}' > ~/terraform_keypair.pem",
      "chmod 400 terraform_keypair.pem",
      "mkdir -p ~/ansible_files",
      "echo '${file("ansible_setup.yaml")}' > ~/ansible_files/ansible_setup.yaml",
      "ansible-playbook -i ansible_inventory.ini ~/ansible_files/ansible_setup.yaml"
    ]
  }
}
