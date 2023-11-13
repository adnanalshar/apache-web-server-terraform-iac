resource "aws_instance" "webserver_instance" {
  ami                         = data.aws_ssm_parameter.webserver_ami.value
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
  subnet_id                   = module.vpc.public_subnets[0]
  user_data                   = file("user_data.sh")
  tags = {
    Name = "webserver"
  }
}