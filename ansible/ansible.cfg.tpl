[defaults]
host_key_checking = false
remote_user = ec2-user
ask_pass = false
private_key_file = /Users/ptgiang/Programing/Startup/prostylee/prostylee-aws/ansible/prostylee-staging.pem
roles_path = /Users/ptgiang/Programing/Startup/prostylee/prostylee-aws/ansible/roles

[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false