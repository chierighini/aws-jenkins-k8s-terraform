# https://kubernetes.io/docs/reference/ports-and-protocols/

#==============NODE=====================

resource "aws_security_group" "k8s_node_sg" {
  name   = "k8s_node"
  vpc_id = aws_vpc.main_vpc.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
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

# Kubelet API
resource "aws_security_group_rule" "node_Kubelet_API" {
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.k8s_master_sg.id
  security_group_id        = aws_security_group.k8s_node_sg.id
}

# NodePort Servicest
resource "aws_security_group_rule" "node_NodePort_Servicest" {
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.k8s_master_sg.id
  security_group_id        = aws_security_group.k8s_node_sg.id
}

#==============MASTER=====================

resource "aws_security_group" "k8s_master_sg" {
  name   = "k8s_master"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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

# Kubernetes API Server
resource "aws_security_group_rule" "master_k8s_API_Server" {
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.k8s_node_sg.id
  security_group_id        = aws_security_group.k8s_master_sg.id
}

# etcd server client API
resource "aws_security_group_rule" "mater_etcd_server_client_API" {
  from_port                = 2379
  to_port                  = 2380
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.k8s_node_sg.id
  security_group_id        = aws_security_group.k8s_master_sg.id
}

# Kubelet API
resource "aws_security_group_rule" "master_Kubelet_API" {
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.k8s_node_sg.id
  security_group_id        = aws_security_group.k8s_master_sg.id
}

# kube-scheduler
resource "aws_security_group_rule" "master_kube_scheduler" {
  from_port                = 10259
  to_port                  = 10259
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.k8s_node_sg.id
  security_group_id        = aws_security_group.k8s_master_sg.id
}

# kube-controller-manager
resource "aws_security_group_rule" "master_kube_controller_manager" {
  from_port                = 10257
  to_port                  = 10257
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.k8s_node_sg.id
  security_group_id        = aws_security_group.k8s_master_sg.id
}
