terraform {
  backend "s3" {
    bucket = "unique-bucket-name-0"
    key    = "terraform/tfstate"
    region = "us-east-1"
  }
}
