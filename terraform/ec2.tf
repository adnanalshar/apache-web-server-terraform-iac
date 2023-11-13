resource "aws_key_pair" "webserver_key" {
  key_name   = "webserver_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "webserver_instance" {
  ami                         = data.aws_ssm_parameter.webserver_ami.value
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.webserver_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
  subnet_id                   = module.vpc.public_subnets[*]
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>My Test Website With Help From Terraform Provisioner</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
  tags = {
    Name = "webserver"
  }
}