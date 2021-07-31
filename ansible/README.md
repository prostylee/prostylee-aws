# How to use Ansible to run tasks on EC2 
For setup AWS Infrastructure as Code

## Create S3 bucket to store terraform state

If no bucket exists `prostylee-secure`, go to AWS S3, create bucket name `prostylee-secure` with versioning enabled.

## Set up Ansible

> brew install ansible

> ansible --version


## Config Ansible

### Ansible Vault to store credentials

Reference: [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

Create a new Ansible Vault file

> ansible-vault create aws-cred.yml

Edit a new Ansible Vault file

> ansible-vault edit aws-cred.yml

View a new Ansible Vault file

> ansible-vault view aws-cred.yml

Press `ESC` to exit

Next:

> `:wq!` to Save and exit

> `:q!` to Exit without save


### Ansible Configuration file

Create a folder name: `roles`

Create `ansible.cfg` file

> mkdir /etc/ansible

> vim /etc/ansible/ansible.cfg

Copy the content of `ansible.cfg.tpl` file into this console

> Remember to copy a `prostylee-staing.pem` file and replace the paths with the correct one


## Install PIP on target

Reference: [PIP installation guide](https://www.tecmint.com/install-pip-in-linux/)

To install pip in Linux, run the appropriate command for your distribution as follows:

> sudo yum install epel-release

> sudo yum install python-pip

To connect with AWS cloud Ansible need boto python library installed on Host

> pip3 install boto3


## Run Ansible

> ansible prostylee -m ping -i inventory.txt

> ansible-playbook playbook-prostylee-be.yml -i inventory.txt

If the playbook required to have a credential, please put it in aws-cred.yml file and run command:

> ansible-playbook playbook-prostylee-be.yml -i inventory.txt --ask-vault-pass

If there is required to run a command with root privilege:

> ansible-playbook playbook-prostylee-be.yml -i inventory.txt --ask-vault-pass --ask-become-pass

## Install Roles

Reference:

- See documentation [here](roles/README.md)

### Install JDK

Commands:

> ansible-galaxy install kami911.java_oracle_jdk11

> ansible-galaxy list

Add roles in playbook

```
roles:
  - kami911.java_open_jdk11
```


### IMPORTANT

Carefully to put credential data on github like `.pem`, aws `client key`, aws `secret key`, `terraform.tfstate`.


