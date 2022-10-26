resource "aws_key_pair" "ssh-key-jenkins" {
  key_name   = "ssh-key-jenkins"
  public_key = var.jenkins-public-key
}
