resource "aws_instance" "k8s_node" {
  ami                         = "ami-0f72d3c899140e51a"
  instance_type               = "t3.small"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.k8s_node_sg.id}"]
  key_name                    = var.ssh_key_name

  tags = {
    Name = "K8s-Node"
  }

}

resource "aws_instance" "k8s_master" {
  ami                         = "ami-0f72d3c899140e51a"
  instance_type               = "t3.small"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.k8s_master_sg.id}"]
  key_name                    = var.ssh_key_name

  tags = {
    Name = "K8s-Master"
  }

}
