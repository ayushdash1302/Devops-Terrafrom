+++++++++++++++++++
terraform.tfvars
+++++++++++++++++++

# terraform-dev.tfvars

instance_type   =   "t3.micro"
tag             =   "EC2 Instance for DEV"
location        =    "eu-north-1"


# terraform-qa.tfvars

instance_type   =   "t3.micro"
tag             =   "EC2 Instance for QA"
location        =    "eu-north-1"

# terraform-prod.tfvars

instance_type   =   "t3.micro"
tag             =   "EC2 Instance for PROD"
location        =    "eu-north-1"


--------------------------------------------------
--------------------------------------------------

# 1. terraform init for DEV 

terraform init --var-file="terraform-dev.tfvars"

# 2. terraform plan for DEV 

terraform plan --var-file="terraform-dev.tfvars"

# 3. terraform apply for DEV 

terraform apply --var-file="terraform-dev.tfvars"

--------------------------------------------------
Variables in Terraform are used to define input values that can be assigned dynamically when running Terraform commands.
They allow for reusability and flexibility in configurations. On the other hand, tfvars files are used to assign specific values to variables.
They provide a convenient way to organize and customize values for variables, particularly for different environments.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

