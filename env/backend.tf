terraform {
  backend "s3" {
    bucket         = "terraform-workspace-demo-backend"
    key            = "env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-workspace-lock"
  }
}
