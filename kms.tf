resource "aws_key_pair" "general_ssh_key" {
  key_name   = "general_ssh_key"
  public_key = var.general_ssh_key
}
