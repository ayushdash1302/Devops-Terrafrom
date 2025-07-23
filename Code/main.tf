#vi main.tf -

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_instance" "example" {
  ami           = "ami-05ffe3c48a9991133"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"  # Change to your desired instance type

  key_name = "devops-batch"  # Change to your existing key pair name

  tags = {
    Name = "Amazon Linux 2 Instance"
  }
}

output "instance_ip" {
  value = aws_instance.example.public_ip
}



-------------------------------------------------
String
-------------------------------------------------

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_instance" "ec2_example" {

   ami           = "ami-05ffe3c48a9991133"
   instance_type =  var.instance_type

   tags = {
           Name = "Terraform EC2"
   }
}

variable "instance_type" {
   description = "Instance type t2.micro"
   type        = string
   default     = "t2.micro"
}

----------------------------------------------------
Integer
----------------------------------------------------

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_instance" "ec2_example" {

   ami           = "ami-05ffe3c48a9991133"
   instance_type =  "t2.micro"
   count = var.instance_count

   tags = {
           Name = "Terraform EC2"
   }
}

variable "instance_count" {
  description = "EC2 instance count"
  type        = number
  default     = 2
}

--------------------------------------------------
Bollean  ggVGd
--------------------------------------------------

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_instance" "ec2_example" {

   ami           = "ami-05ffe3c48a9991133"
   instance_type =  "t2.micro"
   count = 1
  associate_public_ip_address = var.enable_public_ip

   tags = {
           Name = "Terraform EC2"
   }

}

variable "enable_public_ip" {
  description = "Enable public IP address"
  type        = bool
  default     = true
}

----------------------------------------------------
List  ggVGd
----------------------------------------------------

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}
resource "aws_instance" "ec2_example" {

   ami           = "ami-05ffe3c48a9991133"
   instance_type =  "t2.micro"
   count = 1

   tags = {
           Name = "Terraform EC2"
   }

}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}

--------------------------------------------------
Map
--------------------------------------------------

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}
resource "aws_instance" "ec2_example" {

   ami           = "ami-05ffe3c48a9991133"
   instance_type =  "t2.micro"

   tags = var.project_environment

}


variable "project_environment" {
  description = "project name and environment"
  type        = map(string)
  default     = {
    project     = "project-alpha",
    environment = "dev"
  }
}



++++++++++++++++++++++++++++++++++++++++++++++++
Output,Loop,Provisioner,modules,remote backened
++++++++++++++++++++++++++++++++++++++++++++++++


Output Variable

----------------------------------------------------

# main.tf

# Provider Configuration
provider "aws" {
  region = "us-east-1"  # Update with your desired AWS region
}

# Resource Configuration
resource "aws_instance" "example_instance" {
  ami           = "ami-0195204d5dce06d99"  # Update with your desired AMI ID
  instance_type = "t2.micro"  # Update with your desired instance type

  tags = {
    Name = "ExampleInstance"
  }
}

# Output Variables
output "instance_id" {
  value       = aws_instance.example_instance.id
  description = "The ID of the created EC2 instance"
  sensitive   = true
}

output "public_ip" {
  value       = aws_instance.example_instance.public_ip
  description = "The public IP address of the created EC2 instance"
}


-------------------------------------------------------------------
Provisioner remote-exec
-------------------------------------------------------------------

# main.tf

# Provider Configuration
provider "aws" {
  region = "eu-north-1"  # Update with your desired AWS region
}

# Resource Configuration
resource "aws_instance" "example_instance" {
  ami           = "ami-0437df53acb2bbbfd"  # Update with your desired AMI ID
  instance_type = "t3.micro"  # Update with your desired instance type

  key_name      = "Project"  # Update with the name of your key pair

  tags = {
    Name = "ExampleInstance"
  }

  # Connection Configuration
  connection {
    type        = "ssh"
    user        = "Project"  # Update with the appropriate username for your AMI
    private_key = file("C:/Users/ayush/Downloads/Project.pem")  # Update with the path to your private key file
    timeout     = "2m"
    host        = self.public_ip
  }

  # Provisioners
  provisioner "remote-exec" {
    inline = [
      "echo 'Public IP: ${self.public_ip}' > /home/ec2-user/server_info.txt",
      "echo 'Instance ID: ${self.id}' >> /home/ec2-user/server_info.txt"
    ]
  }
}


-------------------------------------------------------------------
Loop
-------------------------------------------------------------------

# main.tf

# Provider Configuration
provider "aws" {
  region = "eu-north-1"  # Update with your desired AWS region
}

# Variable Definition
variable "instance_names" {
  description = "List of instance names"
  type        = list(string)
  default     = ["Instance-1", "Instance-2", "Instance-3"]  # Update with your desired instance names
}

# Resource Configuration
resource "aws_instance" "example_instance" {
  for_each      = toset(var.instance_names)
  ami           = "ami-0437df53acb2bbbfd"  # Update with your desired AMI ID
  instance_type = "t3.micro"  # Update with your desired instance type

  key_name      = "Project"  # Update with the name of your key pair

  tags = {
    Name = each.value
  }
}



By using for_each = toset(var.instance_names), Terraform knows to create a separate instance for each element in the list. In this example, 
Terraform will create three instances because the instance_names list has three elements.

If you update the instance_names list with more or fewer elements, Terraform will adjust the number of instances it creates accordingly. 
This flexibility allows you to dynamically scale the number of instances based on the length of the list.


----------------------------------------------------------------------
Modules
----------------------------------------------------------------------

modules created

--------------------------------------
Remote backened
--------------------------------------

--------------------------------------------------------------------

Terraform on windows

--------------------------------------------------------------------

- download windows file from official website
- extract the zip file
- copy the extracted files to c drive and set the environment variable
- Search for "Environment Variables": Type "Environment Variables" in the search bar and select the "Edit the system environment variables" option that appears.
- Edit the "Path" variable: In the Environment Variables window, locate the "Path" variable under the "System variables" section and click on the "Edit" button
-Add Terraform to the Path: In the Edit Environment Variable window, click on the "New" button and enter the path to the Terraform executable directory (the location where you found the terraform.exe file). For example, if Terraform is installed in C:\Program Files\Terraform, you would add C:\Program Files\Terraform to the Path.
- change the directory in the terminal
Set-Location -LiteralPath 'F:\FBS and Silicon\Silicon\DevOps[31-05-2023]\Terraform-script'
