# modules/ec2/main.tf
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${terraform.workspace}-ec2-instance"
  }

  user_data = file("${path.module}/user_data.tpl.sh")
}