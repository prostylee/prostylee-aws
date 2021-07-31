# prostylee-aws
For setup AWS Infrastructure as Code

# Common command line

Reference: https://docs.amplify.aws/cli

> amplify add auth

> amplify update auth

> amplify remove auth


> amplify status

> amplify push

> amplify push --force

## Run by environment

Reference: 
- https://docs.amplify.aws/cli/teams/overview
- https://docs.amplify.aws/cli/teams/commands#list-environments


> amplify env list

> amplify env add

> amplify push

> amplify env checkout staging


```
After first deployment, we need to manually update:

- Go to Cognito User Pools -> Triggers -> Update Post confirmation and Pre Token Generation.

- Go to CloudFormation template -> ServerlessImageHandler -> update S3 bucket name to a new environment.

```


* Delete environment:

> amplify env remove test

# Image service handler

Template file : AWS CloudFormation

# Switch AWS Account

- Remove file: amplify/team-provider-info.json
- amplify configure
- amplify init
- amplify hosting add
- Select Hosting with Amplify Console
- amplify publish
