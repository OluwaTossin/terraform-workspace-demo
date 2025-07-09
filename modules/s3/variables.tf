# variables.tf
variable "ami" {
  default = "ami-0df368112825f8d8f" # Ubuntu 24.04 (update to suit region)
}
variable "instance_type" {
  default = "t2.micro"
}
