#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-d651b8ac
#
# Your subnet ID is:
#
#     subnet-9d9493c7
#
# Your security group ID is:
#
#     sg-2788a154
#
# Your Identity is:
#
#     NWI-vault-mole
#
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_secret_key" {}
variable "aws_access_key" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

terraform {
  backend "atlas" {
    name = "red5bongo/training"
  }
}

resource "aws_instance" "web" {
  # ...
  count = "2"
  ami                    = "ami-d651b8ac"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-9d9493c7"
  vpc_security_group_ids = ["sg-2788a154"]

  tags {
    Identity = "NWI-vault-mole"
    Owner    = "Wil"
    Version  = "0.1"
    Name     = "web-${count.index+1}"
  }
}

#module "example" {
#  source = "./example-module"
#
#  command = "echo 'Goodbye World!'"
#}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
