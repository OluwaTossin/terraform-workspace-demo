resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  user_data = templatefile("${path.module}/user_data.tpl.sh", {
    workspace = terraform.workspace
  })

  tags = {
    Name = "${terraform.workspace}-ec2-instance"
  }
}
