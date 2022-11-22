variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "ssh_key_name" {
  type = string
}

variable "aws_azs" {
  type = list(string)
}
