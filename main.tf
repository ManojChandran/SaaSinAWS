#----root/main.tf-----

provider "aws" {
  region = "${var.aws_region}"
}
