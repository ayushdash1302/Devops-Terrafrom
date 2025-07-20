----------------------------
main.tf
----------------------------

provider "aws" {
   region     = var.location
}

resource "aws_instance" "ec2_example" {

   ami           = "ami-0195204d5dce06d99"
   instance_type =  var.instance_type

   tags = {
           Name = var.tag
   }
}
