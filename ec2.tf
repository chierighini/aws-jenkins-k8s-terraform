resource "aws_instance" "k8s_node" {
  ami                         = "ami-0f72d3c899140e51a"
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.main_public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_allow_ssh_jenkins.id}"]
  key_name                    = aws_key_pair.general_ssh_key.key_name

  tags = {
    Name = "K8s-Node"
  }

}

resource "aws_instance" "k8s_master" {
  ami                    = "ami-0f72d3c899140e51a"
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.main_public.id
  vpc_security_group_ids = ["${aws_security_group.k8s_master_sg.id}"]
  key_name               = aws_key_pair.general_ssh_key.key_name

  tags = {
    Name = "K8s-Master"
  }

}
