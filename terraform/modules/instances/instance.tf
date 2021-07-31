variable "ENV" {
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}

variable "VPC_ID" {
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "prostylee-env.pub"
}



# EC2

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami

data "aws_ami" "linux" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "prostylee-be" {
  ami           = data.aws_ami.linux.id
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]

  # the public SSH key
  key_name = aws_key_pair.prostylee-keypair.key_name

  tags = {
    Name         = "instance-${var.ENV}"
    Environment  = var.ENV
    App          = "prostylee"
  }
}

output "instance_id" {
  description = "The ID of the Instance"
  value       = aws_instance.prostylee-be.id
}



# Security group

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "allow-ssh" {
  vpc_id      = var.VPC_ID
  name        = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "allow-ssh"
    Environment  = var.ENV
    App          = "prostylee"
  }
}

resource "aws_security_group" "allow-http" {
  vpc_id      = var.VPC_ID
  name        = "allow-http-${var.ENV}"
  description = "security group that allows http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "allow-http"
    Environment  = var.ENV
    App          = "prostylee"
  }
}



# Key Pair
# Reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

resource "aws_key_pair" "prostylee-keypair" {
  key_name   = "prostylee-${var.ENV}"
  public_key = file("${abspath(path.root)}/${var.PATH_TO_PUBLIC_KEY}")
}

