output "jenkins_ip_address" {
  value = aws_instance.jenkins-instance.public_ip
}

output "k8s_node_ip_address" {
  value = aws_instance.k8s_node.public_ip
}

output "k8s_master_ip_address" {
  value = aws_instance.jenkins-instance.private_ip
}
