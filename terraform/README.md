# How to use Terraform to create AWS Infrastructure
For setup AWS Infrastructure as Code


### Prepare Key Pair file

Reference: [Amazon EC2 key pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

Copy file `prostylee-staging.pem` into this folder

Use the following command to set the permissions of your private key file so that only you can read it

> chmod 400 prostylee-staging.pem

Retrieve the public key from the private key

> ssh-keygen -y -f /path_to_key_pair/my-key-pair.pem

Save the result into file prostylee-staging.pub


### Set AWS credentials

Reference: [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

> export AWS_ACCESS_KEY_ID="anaccesskey"

> export AWS_SECRET_ACCESS_KEY="asecretkey"


### Run Terraform

Reference: [Infrastructure as Code with Terraform](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started)

> terraform init

> terraform plan

> terraform apply