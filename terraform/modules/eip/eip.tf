variable "ENV" {
}

variable "INSTANCE_ID" {
}

# Elastic IP

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "prostylee-be" {
  vpc = true

  tags = {
    Name         = "eip"
    Environment  = var.ENV
    App          = "prostylee"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association

resource "aws_eip_association" "eip-assoc-prostylee-be" {
  instance_id   = var.INSTANCE_ID
  allocation_id = aws_eip.prostylee-be.id
}