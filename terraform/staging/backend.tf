terraform {
  backend "s3" {
    bucket = "prostylee-secure"
    key    = "terraform-staging"
    region = "ap-northeast-2"
  }
}