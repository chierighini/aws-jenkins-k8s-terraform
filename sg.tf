resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH and Jenkins inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins web traffic
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# https://kubernetes.io/docs/reference/ports-and-protocols/

resource "aws_security_group" "k8s_node_sg" {
  name   = "k8s_node"
  vpc_id = aws_vpc.main_vpc.id

  # SSH
  ingress {
    from_port   = 22
    to_protocol = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubelet API
  ingress {
    from_port                = 10250
    to_protocol              = 10250
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.k8s_master_sg.id
  }

  # NodePort Servicest
  ingress {
    from_port                = 30000
    to_protocol              = 32767
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.k8s_master_sg.id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_master_sg" {
  name   = "k8s_master"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_protocol = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubernetes API Server
  ingress {
    from_port                = 6443
    to_protocol              = 6443
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.k8s_node_sg.id
  }

  # etcd server client API
  ingress {
    from_port                = 2379
    to_protocol              = 2380
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.k8s_node_sg.id
  }

  # Kubelet API
  ingress {
    from_port                = 10250
    to_protocol              = 10250
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.k8s_node_sg.id
  }

  # kube-scheduler
  ingress {
    from_port                = 10259
    to_protocol              = 10259
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.k8s_node_sg.id
  }

  # kube-controller-manager
  ingress {
    from_port                = 10257
    to_protocol              = 10257
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.k8s_node_sg.id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
