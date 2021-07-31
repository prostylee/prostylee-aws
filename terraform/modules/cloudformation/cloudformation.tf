variable "ENV" {
}

variable "S3_BUCKET_NAME" {
}

# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack
# https://docs.aws.amazon.com/solutions/latest/serverless-image-handler/deployment.html

resource "aws_cloudformation_stack" "img-hndlr" {
  name = "img-hndlr-${var.ENV}"
  capabilities = ["CAPABILITY_NAMED_IAM"]

  parameters = {
    CorsEnabled                 = "No"
    CorsOrigin                  = "*"
    SourceBuckets               = var.S3_BUCKET_NAME
    DeployDemoUI                = "No"
    LogRetentionPeriod          = 3
    EnableSignature             = "No"
    SecretsManagerSecret        = ""
    SecretsManagerKey           = ""
    EnableDefaultFallbackImage  = "No"
    FallbackImageS3Bucket       = ""
    FallbackImageS3Key          = ""
    AutoWebP                    = "No"
  }

  template_url = "https://prostylee-cloudformation-template.s3.ap-northeast-2.amazonaws.com/serverless-image-handler.template"

  tags = {
    Name         = "serverless-image-handler"
    Environment  = var.ENV
    App          = "prostylee"
  }
}