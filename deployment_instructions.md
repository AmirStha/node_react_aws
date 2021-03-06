# Steps for deployment

## Prerequisites

- aws cli(installation: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- docker (installation: https://www.docker.com/products/docker-desktop)
- nodejs
- aws iam user with proper access
- git
- code commit access

## Note:

- Make all the service shell scripts executable:

  Example

  ```bash
    $ chmod +x ./service_scripts/*
  ```

- For scripts to work you must be in the root directory.

**_please note that:_**

- **_4 cloudformation stacks need to be deployed in total._**

- **_the stackname must be unique and use your own region and username._**

- **_after logging in to bit via cli look into your .npmrc file for bit-token._**

# Repo Stacks

<!-- ## Common Steps

- ./service_scripts/create_stack.sh shailendra-s3-deploy-ecs main.ecs.yaml 7b76e084-98d0-4cf6-852b-50aabea4e593(where the three parameters are stackname, yamlConfigFile, bitToken) -->

## 1. Codecommit Stack

- To create code commit repo

  Example

  ```bash
  ./service_scripts/create_stack.sh stack_name="projectrt-ecs-fargate-deploy" yaml_file="main.codecommit.yaml" profile="default" user="shailendra" token="bit-token" region="ap-south-1" s3_branch="staging" ecs_branch="master" team="rt" ecs_cpu=512 ecs_memory=1024
  ```

  replace the value inside with your required inputs,

  - "**stack_name**" should be unique
  - "**yaml_file**" is the file used for the task for codecommit is main.codecommit.yaml
  - "**profile**" is the aws profile you want to use ( refer to ~/.aws/config)
  - "**user**" can be only those accounts with access to aws resources, ( shailendra and amir are valid and tested aws users)
  - "**token**" is the bit node token, for now you can use "7b76e084-98d0-4cf6-852b-50aabea4e593"
  - "**region**" is the aws region you want to deploy your application
  - "**s3_branch**" is the branch from where the s3 deployed starts
  - "**ecs_branch**" is the branch from where the ecs deployed starts
  - "**team**" the team to which the current user belongs to(you)
  - "**ecs_cpu**" cpu for ecs fargate or ec2
  - "**ecs_memory**" memory for ecs fargate or ec2
    \

* check if resources are created in aws console(Cloudformation Section)
* push the code to the code commit repo(manual for now on the first time)
* To push follow the two steps:

  ```bash
  git remote add <origin_name> <code_commit_repo_url>
  ```

* please push your codes to branch "**master**" and "**staging**" for the stack to perform as expected.

  Example
  \
   code_commit_repo_url: https://git-codecommit.<region: example ap-south-1>.amazonaws.com/v1/repos/<example:projectrt-codecommit-node-react>

  you can also find it in code commit (aws console), just use it for now.

  ```bash
  git push --set-upstream <origin_name> <branch_name>
  ```

currently cicd trigger branch for s3 deployment is **master** and for ecs deployment is **staging** by default and one common code commit repo is used for both the deployments

## 2. ECR Stack

- To create ecr repo
  Example

  ```bash
  ./service_scripts/create_stack.sh stack_name="projectrt-ecr-repo" yaml_file="main.docker_ecr.yaml" profile="default" user="shailendra" token="bit-token" region="ap-south-1" s3_branch="staging" ecs_branch="master" team="rt" ecs_cpu=512 ecs_memory=1024
  ```

  replace the value inside with your required inputs

  - "**stack_name**" should be unique
  - "**yaml_file**" is the file used for the task for codecommit is main.s3.yaml
  - "**profile**" is the aws profile you want to use ( refer to ~/.aws/config)
  - "**user**" can be only those accounts with access to aws resources, ( shailendra and amir are valid and tested aws users)
  - "**token**" is the bit node token, for now you can use "7b76e084-98d0-4cf6-852b-50aabea4e593"
  - "**region**" is the aws region you want to deploy your application
  - "**s3_branch**" is the branch from where the s3 deployed starts
  - "**ecs_branch**" is the branch from where the ecs deployed starts
  - "**team**" the team to which the current user belongs to(you)
  - "**ecs_cpu**" cpu for ecs fargate or ec2
  - "**ecs_memory**" memory for ecs fargate or ec2

# Deployment Stacks

## 3. S3 Stack

- To create the stack
  \
   Example

  ```bash
  ./service_scripts/create_stack.sh stack_name="projectrt-s3-deploy" yaml_file="main.s3.yaml" profile="default" user="shailendra" token="bit-token" region="ap-south-1" s3_branch="staging" ecs_branch="master" team="rt" ecs_cpu=512 ecs_memory=1024
  ```

  replace the value inside with your required inputs:

  - "**stack_name**" should be unique
  - "**yaml_file**" is the file used for the task for codecommit is main.s3.yaml
  - "**profile**" is the aws profile you want to use ( refer to ~/.aws/config)
  - "**user**" can be only those accounts with access to aws resources, ( shailendra and amir are valid and tested aws users)
  - "**token**" is the bit node token, for now you can use "7b76e084-98d0-4cf6-852b-50aabea4e593"
  - "**region**" is the aws region you want to deploy your application
  - "**s3_branch**" is the branch from where the s3 deployed starts
  - "**ecs_branch**" is the branch from where the ecs deployed starts
  - "**team**" the team to which the current user belongs to(you)
  - "**ecs_cpu**" cpu for ecs fargate or ec2
  - "**ecs_memory**" memory for ecs fargate or ec2

## 4. ECS Stack

**_Please note the localImage for push and build must be same._**

- build docker image
  \
   Example

  ```bash
  ./service_scripts/build.sh   localImage="ecr-node-react" token="bit-token"
  ```

- update details inside push
  \
   Example

  ```bash
  ./service_scripts/push.sh  profile="default" region="ap-south-1" localImage="ecr-node-react" ecrRepo="ecr-repo full url"
  ```

  replace the value inside with your required inputs

  - "**profile**" is the aws profile you want to use ( refer to ~/.aws/config)
  - "**region**" is the aws region you want to deploy your application
  - "**localImage**" is the image built using docker build
  - "**ecrRepo**" the remote ecr repo created for hosting the localImage)
    \

* To create ecs stack
  \
   Example

  ```bash
  ./service_scripts/create_stack.sh stack_name="projectrt-ecs-fargate-deploy" yaml_file="main.ecs.yaml" profile="default" user="shailendra" token="bit-token" region="ap-south-1" s3_branch="staging" ecs_branch="master" team="rt" ecs_cpu=512 ecs_memory=1024
  ```

  replace the value inside with your required inputs

  - "**stack_name**" should be unique
  - "**yaml_file**" is the file used for the task for codecommit is main.s3.yaml
  - "**profile**" is the aws profile you want to use ( refer to ~/.aws/config)
  - "**user**" can be only those accounts with access to aws resources, ( shailendra and amir are valid and tested aws users)
  - "**token**" is the bit node token, for now you can use "7b76e084-98d0-4cf6-852b-50aabea4e593"
  - "**region**" is the aws region you want to deploy your application
  - "**s3_branch**" is the branch from where the s3 deployed starts
  - "**ecs_branch**" is the branch from where the ecs deployed starts
  - "**team**" the team to which the current user belongs to(you)
  - "**ecs_cpu**" cpu for ecs fargate or ec2
  - "**ecs_memory**" memory for ecs fargate or ec2

## Deploy in a new AWS Account

```bash
aws s3 cp ./cloudformation/templates_ecs s3://bottle-ecs-deploy-resources-bucket/templates --recursive
```

- If you are going to deploy in a completely new AWS account, please copy the cloudformation templates to an S3 bucket (for ECS deployment) and keep note of that s3 bucket, the default nomenclature is "**bottle-ecs-deploy-resources-bucket**" and the rest of the process is same as above

## To delete Stacks created from above steps

Example
\

```bash
  ./service_scripts/delete_stack.sh stack_name="shailendra-ecs-stack" profile="learn" region="us-west-1"
```

replace the value inside with your required inputs

- "**stack_name**" should be unique
- "**profile**" is the aws profile you want to use ( refer to ~/.aws/config)
  - "**region**" is the aws region you want to deploy your application
