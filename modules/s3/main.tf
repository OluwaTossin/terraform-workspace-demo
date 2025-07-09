resource "aws_s3_bucket" "env_bucket" {
  bucket = "tf-ws-${terraform.workspace}-${random_string.suffix.result}"
  force_destroy = true

  tags = {
    Environment = terraform.workspace
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
