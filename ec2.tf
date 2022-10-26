resource "aws_instance" "jenkins-instance" {
  ami                         = "ami-0f72d3c899140e51a"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  subnet_id                   = aws_subnet.main_public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key-jenkins.key_name
  user_data                   = file("install_jenkins.sh")

  tags = {
    Name = "Jenkins-Instance"
  }
}
